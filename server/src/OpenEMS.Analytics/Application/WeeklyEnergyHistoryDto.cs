using OpenEMS.Analytics.Queries;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Analytics.Application;

[Mapper]
public partial class WeeklyEnergyHistoryDto
{
    public required IReadOnlyList<WeeklyEnergyDataPointDto> Consumers { get; init; }
    public required IReadOnlyList<WeeklyEnergyDataPointDto> Producers { get; init; }
    public required IReadOnlyList<WeeklyEnergyDataPointDto> ElectricityMetersConsumption { get; init; }
    public required IReadOnlyList<WeeklyEnergyDataPointDto> ElectricityMetersFeedIn { get; init; }

    public static partial WeeklyEnergyHistoryDto From(EnergyHistory<DayOfWeek> energyHistory);

    private static WeeklyEnergyDataPointDto MapToDto(EnergyDataPoint<DayOfWeek> dataPoint)
    {
        return new WeeklyEnergyDataPointDto(dataPoint.Key, dataPoint.Energy);
    }
}
