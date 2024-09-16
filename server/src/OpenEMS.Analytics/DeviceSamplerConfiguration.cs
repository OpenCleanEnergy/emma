namespace OpenEMS.Analytics;

public class DeviceSamplerConfiguration
{
    public required TimeSpan SamplingInterval { get; init; } = TimeSpan.FromMinutes(1);
}
