using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Queries;

public class TotalEnergyData
{
    public required WattHours TotalEnergyProduction { get; init; }
    public required WattHours TotalGridEnergyConsumption { get; init; }
    public required WattHours TotalGridEnergyFeedIn { get; init; }
}
