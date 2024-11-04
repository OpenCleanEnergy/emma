namespace OpenEMS.Analytics.Application;

public class MonthlyAnalysisDto
{
    public required MonthlyEnergyHistoryDto EnergyHistory { get; init; }
    public required AnalyticsMetricsDto Metrics { get; init; }
}
