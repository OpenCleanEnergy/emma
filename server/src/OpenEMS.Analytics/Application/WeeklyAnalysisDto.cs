namespace OpenEMS.Analytics.Application;

public class WeeklyAnalysisDto
{
    public required WeeklyEnergyHistoryDto EnergyHistory { get; init; }
    public required AnalyticsMetricsDto Metrics { get; init; }
}
