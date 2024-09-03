using System.Globalization;
using System.Text.Json.Nodes;
using Serilog;
using Serilog.Events;
using Serilog.Extensions.Hosting;
using Serilog.Formatting.Compact;
using Serilog.Sinks.SystemConsole.Themes;

namespace OpenEMS.Server.Logging;

public static class SerilogLoggerFactory
{
    public static ReloadableLogger GetBootstrapLogger(WebApplicationBuilder builder)
    {
        return ConfigureLogger(
                builder.Configuration,
                builder.Environment,
                new LoggerConfiguration().MinimumLevel.Override(
                    "Microsoft",
                    LogEventLevel.Information
                )
            )
            .CreateBootstrapLogger();
    }

    public static LoggerConfiguration ConfigureLogger(
        IConfiguration configuration,
        IWebHostEnvironment environment,
        LoggerConfiguration loggerConfiguration
    )
    {
        loggerConfiguration
            .ReadFrom.Configuration(configuration)
            .Enrich.FromLogContext()
            .Enrich.WithServiceInfo(ServiceInfo.Name, ServiceInfo.Version)
            .Enrich.With<ClientInfoEnricher>()
            .Destructure.AsScalar<JsonObject>()
            .Destructure.With<ValueObjectDestructuringPolicy>();

        if (
            environment.IsDevelopment()
            || EntryAssembly.GetEntryAssembly() != EntryAssembly.Default
        )
        {
            loggerConfiguration.WriteTo.Console(
                outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:l}{NewLine}{Properties}{NewLine}{Exception}",
                formatProvider: CultureInfo.InvariantCulture,
                applyThemeToRedirectedOutput: true,
                theme: AnsiConsoleTheme.Literate
            );

            if (EntryAssembly.GetEntryAssembly() != EntryAssembly.Default)
            {
                return loggerConfiguration;
            }
        }
        else
        {
            loggerConfiguration.WriteTo.Console(new CompactJsonFormatter());
        }

        var betterStack = configuration.GetSection("BetterStack").Get<BetterStackConfiguration>();
        if (!string.IsNullOrEmpty(betterStack?.SourceToken))
        {
            loggerConfiguration.WriteTo.BetterStack(sourceToken: betterStack.SourceToken);
        }

        var sentry = configuration.GetSection("Sentry")?.Get<SentryConfiguration>();
        if (!string.IsNullOrEmpty(sentry?.Dsn))
        {
            loggerConfiguration.WriteTo.Sentry(options =>
            {
                options.Dsn = sentry.Dsn;
                options.Debug = sentry.Debug;
                options.MinimumBreadcrumbLevel = sentry.MinimumBreadcrumbLevel;
                options.MinimumEventLevel = sentry.MinimumEventLevel;
                options.Environment = environment.EnvironmentName;
                options.Release = ServiceInfo.Version;
            });
        }

        return loggerConfiguration;
    }
}
