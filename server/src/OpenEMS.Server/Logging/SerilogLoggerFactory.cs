using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text.Json.Nodes;
using OpenTelemetry.Resources;
using Serilog;
using Serilog.Events;
using Serilog.Extensions.Hosting;
using Serilog.Formatting.Compact;
using Serilog.Sinks.OpenTelemetry;
using Serilog.Sinks.SystemConsole.Themes;

namespace OpenEMS.Server.Logging;

public static class SerilogLoggerFactory
{
    public static ReloadableLogger GetBootstrapLogger(WebApplicationBuilder builder)
    {
        return ConfigureLogger(
                new LoggerConfiguration().MinimumLevel.Override(
                    "Microsoft",
                    LogEventLevel.Information
                ),
                builder.Configuration,
                builder.Environment
            )
            .CreateBootstrapLogger();
    }

    public static LoggerConfiguration ConfigureLogger(
        LoggerConfiguration loggerConfiguration,
        IConfiguration configuration,
        IWebHostEnvironment environment
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

        var sinks =
            configuration.Get<SerilogSinksConfiguration>()
            ?? throw new ValidationException(
                $"Unable to get {nameof(SerilogSinksConfiguration)} from configuration."
            );

        if (sinks.OpenTelemetry.Endpoint is not null)
        {
            loggerConfiguration.WriteTo.OpenTelemetry(options =>
            {
                var resource = ResourceBuilder
                    .CreateEmpty()
                    .AddService(
                        serviceName: ServiceInfo.Name,
                        serviceVersion: ServiceInfo.Version,
                        autoGenerateServiceInstanceId: false
                    )
                    .Build();

                options.ResourceAttributes = resource.Attributes.ToDictionary();
                options.Endpoint = sinks.OpenTelemetry.Endpoint.ToString();
                options.Protocol = OtlpProtocol.Grpc;
            });
        }

        if (!string.IsNullOrEmpty(sinks.Sentry.Dsn))
        {
            loggerConfiguration.WriteTo.Sentry(options =>
            {
                options.Dsn = sinks.Sentry.Dsn;
                options.Debug = sinks.Sentry.Debug;
                options.MinimumBreadcrumbLevel = sinks.Sentry.MinimumBreadcrumbLevel;
                options.MinimumEventLevel = sinks.Sentry.MinimumEventLevel;
                options.Environment = environment.EnvironmentName;
                options.Release = ServiceInfo.Version;
            });
        }

        return loggerConfiguration;
    }
}
