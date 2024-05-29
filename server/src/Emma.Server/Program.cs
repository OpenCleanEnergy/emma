using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text.Json.Nodes;
using System.Text.Json.Serialization;
using Emma.Application.Shared.Events;
using Emma.Infrastructure.Common.Logging;
using Emma.Infrastructure.Persistence;
using Emma.Infrastructure.Persistence.EntityFramework;
using Emma.Server;
using Emma.Server.Configuration;
using Emma.Server.HostedServices;
using Emma.Server.Identity;
using Emma.Server.LongPolling;
using Emma.Server.ModelBinding;
using Emma.Server.Swagger;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Serilog.Events;
using Serilog.Extensions.Hosting;
using Serilog.Formatting.Compact;
using Serilog.Sinks.SystemConsole.Themes;
using SimpleInjector;
using SimpleInjector.Lifestyles;

using var container = new Container();

var entryAssembly = EntryAssembly.GetEntryAssembly();

if (entryAssembly != EntryAssembly.Default)
{
    args = [.. args, "--environment", "Development"];
}

var builder = WebApplication.CreateBuilder(args);
builder.Configuration.AddDockerSecretsJson();

var services = builder.Services;
var logger = GetBootstrapLogger(builder).ForContext<Program>();
logger.Information("🚀 Started with {EntryAssembly}", entryAssembly);

builder.Services.AddSerilog(configuration =>
    ConfigureLogger(builder.Configuration, builder.Environment, configuration)
);

// Controllers
var mvcBuilder = services
    .AddControllers(options =>
    {
        options.ModelMetadataDetailsProviders.Add(new RequiredBindingMetadataProvider());
    })
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
    });

foreach (var part in Bootstrapper.Assemblies)
{
    mvcBuilder.AddApplicationPart(part);
}

services.AddRouting(options =>
{
    options.LowercaseUrls = true;
    options.LowercaseQueryStrings = true;
});

// Authentication
var keycloakConfiguration =
    builder.Configuration.GetSection("Keycloak").Get<KeycloakConfiguration>()
    ?? throw new InvalidOperationException("Keycloak is not configured.");

services
    .AddAuthentication(options =>
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme
    )
    .AddJwtBearer(options =>
    {
        // https://stackoverflow.com/a/77104803
        options.RequireHttpsMetadata = false;
        options.Authority = string.Empty;
        options.MetadataAddress = keycloakConfiguration.MetadataAddress.ToString();
        options.TokenValidationParameters = new TokenValidationParameters
        {
            RoleClaimType = "groups",
            NameClaimType = keycloakConfiguration.NameClaimType,
            ValidAudience = keycloakConfiguration.ValidAudience,
        };
    });

// Authorization
services
    .AddAuthorizationBuilder()
    .SetDefaultPolicy(new AuthorizationPolicyBuilder().RequireAuthenticatedUser().Build());

services.AddSwaggerGen(keycloakConfiguration);

services.AddIdentity();
services.AddLongPolling();
AddDbContext(builder, container);

services.AddSimpleInjector(container, options => options.AddAspNetCore().AddControllerActivation());
Bootstrapper.Bootstrap(container, builder.Configuration);

if (entryAssembly == EntryAssembly.Default)
{
    builder.Services.AddHostedServices(container);
}

var app = builder.Build();
app.Services.UseSimpleInjector(container);
container.Verify();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseSerilogRequestLogging();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers().RequireAuthorization();

if (entryAssembly == EntryAssembly.Default)
{
    await MigrateDbContext(container);
}

await app.RunAsync();

static ReloadableLogger GetBootstrapLogger(WebApplicationBuilder builder)
{
    return ConfigureLogger(
            builder.Configuration,
            builder.Environment,
            new LoggerConfiguration().MinimumLevel.Override("Microsoft", LogEventLevel.Information)
        )
        .CreateBootstrapLogger();
}

static LoggerConfiguration ConfigureLogger(
    IConfiguration configuration,
    IWebHostEnvironment environment,
    LoggerConfiguration loggerConfiguration
)
{
    loggerConfiguration
        .ReadFrom.Configuration(configuration)
        .Destructure.AsScalar<JsonObject>()
        .Destructure.With<ValueObjectDestructuringPolicy>()
        .Enrich.FromLogContext();

    if (environment.IsDevelopment() || EntryAssembly.GetEntryAssembly() != EntryAssembly.Default)
    {
        loggerConfiguration.WriteTo.Console(
            outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:l}{NewLine}{Properties}{NewLine}{Exception}",
            formatProvider: CultureInfo.InvariantCulture,
            applyThemeToRedirectedOutput: true,
            theme: AnsiConsoleTheme.Literate
        );
    }
    else
    {
        loggerConfiguration.WriteTo.Console(new CompactJsonFormatter());
    }

    return loggerConfiguration;
}

static void AddDbContext(WebApplicationBuilder builder, Container container)
{
    var configuration =
        builder.Configuration.GetRequiredSection("Database").Get<DatabaseConfiguration>()
        ?? throw new ValidationException("Database configuration is required.");

    var connectionString = configuration.GetConnectionString();

    if (EntryAssembly.GetEntryAssembly() == EntryAssembly.EF)
    {
        builder.Services.AddSingleton(Array.Empty<IInterceptor>());
    }
    else
    {
        builder.Services.AddScoped((_) => container.GetAllInstances<IUnitOfWorkInterceptor>());
        builder.Services.AddScoped<IInterceptor, EntityFrameworkUnitOfWorkInterceptor>();

        builder.Services.AddScoped((_) => container.GetInstance<IEventPublisher>());
        builder.Services.AddScoped<IInterceptor, EntityFrameworkEventPublisherInterceptor>();
    }

    builder.Services.AddDbContext<AppDbContext>(
        (provider, options) =>
            options
                .UseNpgsql(connectionString)
                .AddInterceptors(provider.GetRequiredService<IEnumerable<IInterceptor>>())
    );
}

static async Task MigrateDbContext(Container container)
{
    using var scope = AsyncScopedLifestyle.BeginScope(container);
    using var context = container.GetInstance<AppDbContext>();
    await context.Database.MigrateAsync();
}
