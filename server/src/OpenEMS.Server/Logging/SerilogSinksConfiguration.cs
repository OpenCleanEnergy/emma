namespace OpenEMS.Server.Logging;

public class SerilogSinksConfiguration
{
    public BetterStackConfiguration? BetterStack { get; init; }
    public OpenTelemetryConfiguration? OpenTelemetry { get; init; }
    public SentryConfiguration? Sentry { get; init; }
}
