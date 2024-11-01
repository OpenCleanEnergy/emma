namespace OpenEMS.Analytics.Queries;

public class EnergyHistory<TKey>
{
    public required IReadOnlyList<EnergyDataPoint<TKey>> Consumers { get; init; }
    public required IReadOnlyList<EnergyDataPoint<TKey>> Producers { get; init; }
    public required IReadOnlyList<EnergyDataPoint<TKey>> ElectricityMetersConsumption { get; init; }
    public required IReadOnlyList<EnergyDataPoint<TKey>> ElectricityMetersFeedIn { get; init; }
}
