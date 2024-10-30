using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public class OwnConsumptionMetricDto
{
    public required Percentage Percentage { get; init; }
    public required WattHours OwnConsumption { get; init; }
    public required WattHours GridFeedIn { get; init; }
    public required WattHours Production { get; init; }

    public static OwnConsumptionMetricDto From(TotalEnergyData totalEnergyData)
    {
        var production = totalEnergyData.Production;
        var gridFeedIn = totalEnergyData.GridFeedIn;
        var ownConsumption = production - gridFeedIn;
        return new OwnConsumptionMetricDto
        {
            Percentage =
                production == WattHours.Zero
                    ? Percentage.Zero
                    : Percentage.From(ownConsumption / production),
            OwnConsumption = ownConsumption,
            GridFeedIn = gridFeedIn,
            Production = production,
        };
    }
}
