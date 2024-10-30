using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Queries;

public class TotalEnergyData
{
    public required WattHours Production { get; init; }
    public required WattHours GridConsumption { get; init; }
    public required WattHours GridFeedIn { get; init; }
}
