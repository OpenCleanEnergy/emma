using Serilog;
using Serilog.Configuration;

namespace OpenEMS.Server.Logging;

public static class ServiceEnricherExtensions
{
    public static LoggerConfiguration WithServiceInfo(
        this LoggerEnrichmentConfiguration configuration,
        string name,
        string version
    )
    {
        return configuration.WithProperty(
            "Service",
            new Service(name, version),
            destructureObjects: true
        );
    }

    private sealed record Service(string Name, string Version);
}
