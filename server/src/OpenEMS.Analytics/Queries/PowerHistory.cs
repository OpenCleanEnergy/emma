namespace OpenEMS.Analytics.Queries;

public class PowerHistory
{
    public required IReadOnlyList<PowerDataPoint> Consumers { get; init; }
    public required IReadOnlyList<PowerDataPoint> Producers { get; init; }
    public required IReadOnlyList<PowerDataPoint> ElectricityMetersConsume { get; init; }
    public required IReadOnlyList<PowerDataPoint> ElectricityMetersFeedIn { get; init; }
}
