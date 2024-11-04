using OpenEMS.Analytics.Queries;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Analytics.Application;

[Mapper]
public partial class MonthlyEnergyHistoryDto
{
    public required IReadOnlyList<MonthlyEnergyDataPointDto> Consumers { get; init; }
    public required IReadOnlyList<MonthlyEnergyDataPointDto> Producers { get; init; }
    public required IReadOnlyList<MonthlyEnergyDataPointDto> ElectricityMetersConsumption { get; init; }
    public required IReadOnlyList<MonthlyEnergyDataPointDto> ElectricityMetersFeedIn { get; init; }

    public static partial MonthlyEnergyHistoryDto From(EnergyHistory<int> energyHistory);

    private static MonthlyEnergyDataPointDto MapToDto(EnergyDataPoint<int> dataPoint)
    {
        return new MonthlyEnergyDataPointDto(dataPoint.Key, dataPoint.Energy);
    }
}
