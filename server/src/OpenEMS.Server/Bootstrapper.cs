using System.ComponentModel.DataAnnotations;
using System.Reflection;
using System.Text.Json.Serialization;
using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using OpenEMS.Application.Integrations;
using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;
using OpenEMS.Infrastructure;
using OpenEMS.Infrastructure.Devices.Consumers;
using OpenEMS.Infrastructure.Devices.Meters;
using OpenEMS.Infrastructure.Devices.Producers;
using OpenEMS.Infrastructure.Events;
using OpenEMS.Infrastructure.Events.CAP;
using OpenEMS.Infrastructure.Integrations;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Infrastructure.Persistence.EntityFramework;
using OpenEMS.Infrastructure.RequestPipeline;
using OpenEMS.Infrastructure.Shelly;
using OpenEMS.Integrations.Development;
using OpenEMS.Integrations.Shared;
using OpenEMS.Integrations.Shelly;
using OpenEMS.Integrations.Shelly.Application.Callback;
using OpenEMS.Integrations.Shelly.Commands;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Events;
using OpenEMS.Integrations.Shelly.Infrastructure;
using OpenEMS.Server.Configuration;
using OpenEMS.Server.Events;
using OpenEMS.Server.Identity;
using OpenEMS.Server.Integrations;
using OpenEMS.Server.Logging;
using OpenEMS.Server.LongPolling;
using OpenEMS.Server.ModelBinding;
using OpenEMS.Server.Swagger;
using Serilog;

namespace OpenEMS.Server;

public static class Bootstrapper
{
    private static readonly Assembly[] _assemblies =
    [
        typeof(IntegrationsQuery).Assembly,
        // Integrations
        typeof(ShellyIntegrationDescriptor).Assembly,
        typeof(DevelopmentIntegrationDescriptor).Assembly,
    ];

    public static void ConfigureServices(
        IServiceCollection services,
        IConfiguration configuration,
        IWebHostEnvironment env
    )
    {
        AddWeb(services, configuration);
        AddIdentity(services);
        AddLongPolling(services);
        AddLogging(services, configuration, env);
        AddDomain(services);
        AddRequestHandler(services, configuration);
        AddPersistence(services, configuration);
        AddIntegrations(services, configuration);
    }

    public static void ConfigureApp(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // Configure the HTTP request pipeline.
        if (env.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseCors(builder =>
            builder
                .SetIsOriginAllowed(origin =>
                    origin.Contains("localhost", StringComparison.OrdinalIgnoreCase)
                )
                .AllowAnyHeader()
                .AllowAnyMethod()
        );

        app.UseSerilogRequestLogging(options =>
        {
            options.GetLevel = RequestLoggingLevelFactory.GetLevel;
        });

        app.UseRouting();

        app.UseAuthentication();
        app.UseAuthorization();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers().RequireAuthorization();
        });
    }

    private static void AddWeb(IServiceCollection services, IConfiguration configuration)
    {
        // Controllers
        var mvcBuilder = services
            .AddControllers(options =>
            {
                options.ModelMetadataDetailsProviders.Add(new RequiredBindingMetadataProvider());
            })
            .AddControllersAsServices()
            .AddJsonOptions(options =>
            {
                options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
            });

        foreach (var part in _assemblies)
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
            configuration.GetSection("Keycloak").Get<KeycloakConfiguration>()
            ?? throw new InvalidOperationException("'Keycloak' is not configured.");

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

        // Swagger
        services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc(
                "v1",
                new OpenApiInfo
                {
                    Title = "OpenEMS backend server",
                    Version = "v1",
                    Description = $"You **MUST** authorize first!",
                }
            );

            options.SupportNonNullableReferenceTypes();
            options.SchemaFilter<VogenSchemaFilter>();
            options.SchemaFilter<RequireNonNullablePropertiesSchemaFilter>();
            options.ParameterFilter<RequireNonNullableParameterFilter>();

            options.CustomOperationIds(api =>
            {
                var actionId =
                    api.ActionDescriptor.AttributeRouteInfo?.Name
                    ?? api.ActionDescriptor.RouteValues["action"];

                return $"{api.ActionDescriptor.RouteValues["controller"]}_{actionId}";
            });

            var securityId = "oauth";
            options.AddSecurityDefinition(
                securityId,
                new OpenApiSecurityScheme
                {
                    Type = SecuritySchemeType.OAuth2,
                    Description =
                        $"**client_id:** `{keycloakConfiguration.SwaggerClientId ?? "not available"}`",
                    Flows = new OpenApiOAuthFlows
                    {
                        Implicit = new OpenApiOAuthFlow
                        {
                            AuthorizationUrl = keycloakConfiguration.AuthorizationEndpoint,
                        },
                    },
                }
            );
            options.AddSecurityRequirement(
                new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = securityId,
                            },
                        },
                        Array.Empty<string>()
                    },
                }
            );
        });
    }

    private static void AddIdentity(IServiceCollection services)
    {
        services.AddHttpContextAccessor();
        services.AddSingleton<ICurrentUserReader, HttpContextCurrentUserReader>();
    }

    private static void AddLongPolling(IServiceCollection services)
    {
        services.TryAddSingleton(TimeProvider.System);

        services.AddSingleton<DevicesLongPolling>();
        services.AddScoped<
            IInterceptor,
            EntityFrameworkLongPollingInterceptor<DevicesLongPolling>
        >();
    }

    private static void AddLogging(
        IServiceCollection services,
        IConfiguration configuration,
        IWebHostEnvironment env
    )
    {
        services.AddSerilog(loggerConfig =>
            SerilogLoggerFactory.ConfigureLogger(loggerConfig, configuration, env)
        );

        services.AddSingleton<Serilog.ILogger>(Serilog.Log.Logger);

        services.AddSingleton(
            typeof(Application.Shared.Logging.ILogger<>),
            typeof(SerilogLoggerAdapter<>)
        );
    }

    private static void AddDomain(IServiceCollection container)
    {
        container.AddScoped<ISwitchConsumerRepository, SwitchConsumerRepository>();
        container.AddScoped<IElectricityMeterRepository, ElectricityMeterRepository>();
        container.AddScoped<IProducerRepository, ProducerRepository>();
    }

    private static void AddRequestHandler(IServiceCollection services, IConfiguration configuration)
    {
        services.AddMediatR(config =>
            config
                .RegisterServicesFromAssemblies(_assemblies)
                .AddOpenBehavior(typeof(LoggingBehavior<,>))
                .AddOpenBehavior(typeof(TransactionBehavior<,>))
        );

        services.RemoveAll<IMediator>();
        services.RemoveAll<IPublisher>();

        // Events
        services.AddCap(
            configuration.GetSection("Events").Get<CapConfiguration>()
                ?? throw new InvalidOperationException("'Events' is not configured.")
        );

        services.AddSingleton<IEventPublisher, CapEventPublisher>();

        services.AddScoped<MediatREventMediator>();
        services.AddSingleton<IEventMediator, MicrosoftScopedEventMediator<MediatREventMediator>>();

        services.AddSingleton<IEnumerable<EventHandlerDescriptor>>(
            _ => new MicrosoftEventHandlerDescriptorCollection(services)
        );
    }

    private static void AddPersistence(IServiceCollection services, IConfiguration configuration)
    {
        var databaseConfig =
            configuration.GetRequiredSection("Database").Get<DatabaseConfiguration>()
            ?? throw new ValidationException("Database configuration is required.");

        var connectionString = databaseConfig.GetConnectionString();

        if (EntryAssembly.GetEntryAssembly() == EntryAssembly.EF)
        {
            services.AddSingleton(Array.Empty<IInterceptor>());
        }
        else
        {
            services.AddScoped<IInterceptor, EntityFrameworkUnitOfWorkInterceptor>();
        }

        services.AddDbContext<AppDbContext>(
            (provider, options) =>
                options
                    .UseNpgsql(connectionString)
                    .AddInterceptors(provider.GetRequiredService<IEnumerable<IInterceptor>>())
        );

        services.AddHealthChecks().AddDbContextCheck<AppDbContext>();

        services.AddScoped<IUnitOfWork, UnitOfWork>();
        services.Scan(x =>
            x.FromAssemblyOf<IUnitOfWorkInterceptor>()
                .AddClasses(x => x.AssignableTo<IUnitOfWorkInterceptor>())
                .As<IUnitOfWorkInterceptor>()
                .WithScopedLifetime()
        );
    }

    private static void AddIntegrations(IServiceCollection container, IConfiguration configuration)
    {
        container.AddTransient<IExistingDevicesReader, ExistingDevicesReader>();
        container.AddTransient<IDevicesRepository, DevicesRepository>();
        container.AddSingleton(
            typeof(IScopedServiceFactory<>),
            typeof(MicrosoftScopedServiceFactory<>)
        );

        container.Scan(x =>
            x.FromAssemblies(_assemblies)
                .AddClasses(x => x.AssignableTo<IIntegrationDescriptor>())
                .As<IIntegrationDescriptor>()
                .WithTransientLifetime()
        );

        container.Scan(x =>
            x.FromAssemblies(_assemblies)
                .AddClasses(x => x.AssignableTo<ISwitchConsumerIntegration>())
                .As<ISwitchConsumerIntegration>()
                .WithTransientLifetime()
        );

        var config =
            configuration.GetRequiredSection("Integrations").Get<IntegrationsConfiguration>()
            ?? throw new ArgumentException("Failed to read integrations configuration");

        // Shelly
        container.AddSingleton(config.Shelly);
        container.AddSingleton<ShellyTrustTokenValidator>();
        container.AddScoped<IGrantedShellyDeviceRepository, GrantedShellyDeviceRepository>();
        container.AddTransient<IShellyHostsReader, ShellyHostsReader>();
        container.AddSingleton<ShellyHostedService>();
        container.AddSingleton<ShellyWebsocketConfigurationFactory>();
        container.AddSingleton<IShellyWebsocketManager, ShellyWebsocketManager>();
        container.AddSingleton<ShellyWebsocketMessageHandler>();
        container.AddSingleton<ShellyEventSerializer>();

        container.AddTransient<ShellyCommandRequestSerializer>();
        container.AddTransient<ShellyCommandSender>();

        container.AddSingleton(ShellyHostsAutoResetEvent.Instance);
    }
}
