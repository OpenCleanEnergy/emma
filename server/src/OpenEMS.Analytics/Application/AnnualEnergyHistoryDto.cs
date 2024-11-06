using OpenEMS.Analytics.Queries;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Analytics.Application;

[Mapper]
public partial class AnnualEnergyHistoryDto
{
    public required IReadOnlyList<AnnualEnergyDataPointDto> Consumers { get; init; }
    public required IReadOnlyList<AnnualEnergyDataPointDto> Producers { get; init; }
    public required IReadOnlyList<AnnualEnergyDataPointDto> ElectricityMetersConsumption { get; init; }
    public required IReadOnlyList<AnnualEnergyDataPointDto> ElectricityMetersFeedIn { get; init; }

    public static partial AnnualEnergyHistoryDto From(EnergyHistory<int> energyHistory);

    private static AnnualEnergyDataPointDto MapToDto(EnergyDataPoint<int> dataPoint)
    {
        return new AnnualEnergyDataPointDto(dataPoint.Key, dataPoint.Energy);
    }
}
