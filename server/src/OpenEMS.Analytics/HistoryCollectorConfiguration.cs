namespace OpenEMS.Analytics;

public class HistoryCollectorConfiguration
{
    public required TimeSpan SamplingInterval { get; init; } = TimeSpan.FromMinutes(1);
}
