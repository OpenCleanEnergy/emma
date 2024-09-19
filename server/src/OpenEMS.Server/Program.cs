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

var logger = SerilogLoggerFactory.GetBootstrapLogger(builder).ForContext<Program>();
logger.Information("🚀 Started with {EntryAssembly}", entryAssembly);

Bootstrapper.ConfigureServices(builder.Services, builder.Configuration, builder.Environment);

if (entryAssembly != EntryAssembly.Default)
{
    // Do not start hosted services if not running
    // as the default entry assembly to avoid errors
    builder.Services.RemoveAll<IHostedService>();
}

var app = builder.Build();
Bootstrapper.ConfigureApp(app, app.Environment);

var cts = new CancellationTokenSource();
try
{
    if (entryAssembly == EntryAssembly.Default)
    {
        await MigrateDbContext(app.Services);
        await BootstrapCAP(app.Services, cts.Token);
    }

    await app.RunAsync();
}
finally
{
    await cts.CancelAsync();
    cts.Dispose();
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
