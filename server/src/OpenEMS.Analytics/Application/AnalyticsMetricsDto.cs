using OpenEMS.Analytics.Queries;

namespace OpenEMS.Analytics.Application;

public class AnalyticsMetricsDto
{
    public required OwnConsumptionMetricDto OwnConsumption { get; init; }
    public required SelfSufficiencyMetricDto SelfSufficiency { get; init; }

    public static AnalyticsMetricsDto From(TotalEnergyData totalEnergyData)
    {
        return new AnalyticsMetricsDto
        {
            OwnConsumption = OwnConsumptionMetricDto.From(totalEnergyData),
            SelfSufficiency = SelfSufficiencyMetricDto.From(totalEnergyData),
        };
    }
}
