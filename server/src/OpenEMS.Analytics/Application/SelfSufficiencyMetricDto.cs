using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public class SelfSufficiencyMetricDto
{
    public required Percentage Percentage { get; init; }
    public required WattHours OwnConsumption { get; init; }
    public required WattHours GridConsumption { get; init; }
    public required WattHours TotalConsumption { get; init; }

    public static SelfSufficiencyMetricDto From(TotalEnergyData totalEnergyData)
    {
        var ownConsumption = totalEnergyData.Production - totalEnergyData.GridFeedIn;
        var gridConsumption = totalEnergyData.GridConsumption;
        var totalConsumption = gridConsumption + ownConsumption;
        return new SelfSufficiencyMetricDto
        {
            Percentage =
                totalConsumption == WattHours.Zero
                    ? Percentage.Zero
                    : Percentage.From(ownConsumption / totalConsumption),
            OwnConsumption = ownConsumption,
            GridConsumption = gridConsumption,
            TotalConsumption = totalConsumption,
        };
    }
}
