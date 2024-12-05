namespace OpenEMS.Server.Logging;

public class SerilogSinksConfiguration
{
    public OpenTelemetryConfiguration OpenTelemetry { get; init; } = new();
    public SentryConfiguration Sentry { get; init; } = new();
}
