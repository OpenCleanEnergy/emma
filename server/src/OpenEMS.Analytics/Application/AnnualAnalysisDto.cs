namespace OpenEMS.Analytics.Application;

public class AnnualAnalysisDto
{
    public required AnnualEnergyHistoryDto EnergyHistory { get; init; }
    public required AnalyticsMetricsDto Metrics { get; init; }
}
