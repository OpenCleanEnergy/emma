using DotNetCore.CAP;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection.Extensions;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Server;
using OpenEMS.Server.Configuration;
using OpenEMS.Server.Logging;
using Serilog;

var entryAssembly = EntryAssembly.GetEntryAssembly();

if (entryAssembly != EntryAssembly.Default)
{
    args = [.. args, "--environment", "Development"];
}

var builder = WebApplication.CreateBuilder(args);
builder.Configuration.AddDockerSecretsJson();
builder.Host.UseDefaultServiceProvider(
    (context, options) =>
    {
        options.ValidateScopes = true;
        options.ValidateOnBuild = true;
    }
);

var logger = SerilogLoggerFactory.GetBootstrapLogger(builder).ForContext<Program>();
logger.Information("🚀 Started with {EntryAssembly}", entryAssembly);

var cts = new CancellationTokenSource();
try
{
    Bootstrapper.ConfigureServices(builder.Services, builder.Configuration, builder.Environment);

    if (entryAssembly != EntryAssembly.Default)
    {
        // Do not start hosted services if not running
        // as the default entry assembly to avoid errors
        builder.Services.RemoveAll<IHostedService>();
    }

    var app = builder.Build();
    Bootstrapper.ConfigureApp(app, app.Environment);

    if (entryAssembly == EntryAssembly.Default)
    {
        await MigrateDbContext(app.Services);
        await BootstrapCAP(app.Services, cts.Token);
        await app.RunAsync();
    }
}
catch (HostAbortedException)
{
#pragma warning disable S6667 // Logging in a catch clause should pass the caught exception as a parameter.
    logger.Information("🛑 The Host was aborted.");
#pragma warning restore S6667 // Logging in a catch clause should pass the caught exception as a parameter.
}
catch (Exception exception)
{
    logger.Fatal(exception, "Application terminated unexpectedly");
}
finally
{
    await cts.CancelAsync();
    cts.Dispose();
    logger.Information("🌕️ Bye!");
    await Log.CloseAndFlushAsync();
}

static async Task MigrateDbContext(IServiceProvider provider)
{
    var factory = provider.GetRequiredService<IServiceScopeFactory>();
    using var scope = factory.CreateScope();
    using var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    await context.Database.MigrateAsync();
}

static async Task BootstrapCAP(IServiceProvider container, CancellationToken cancellationToken)
{
    // IMPORTANT: Do not dispose the bootstrapper, it is a singleton
    var bootstrapper = container.GetRequiredService<IBootstrapper>();
    await bootstrapper.BootstrapAsync(cancellationToken);
}
