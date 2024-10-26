using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Units;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Analytics.Application;

[Mapper]
public partial class TotalEnergyDataDto
{
    public required WattHours TotalEnergyProduction { get; init; }
    public required WattHours TotalGridEnergyConsumption { get; init; }
    public required WattHours TotalGridEnergyFeedIn { get; init; }

    public static partial TotalEnergyDataDto From(TotalEnergyData totalEnergyData);
}
