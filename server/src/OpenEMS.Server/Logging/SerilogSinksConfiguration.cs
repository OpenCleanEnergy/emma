namespace OpenEMS.Server.Logging;

public class SerilogSinksConfiguration
{
    public BetterStackConfiguration BetterStack { get; init; } = new();
    public OpenTelemetryConfiguration OpenTelemetry { get; init; } = new();
    public SentryConfiguration Sentry { get; init; } = new();
}
