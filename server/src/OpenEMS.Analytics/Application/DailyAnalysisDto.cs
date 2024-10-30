namespace OpenEMS.Analytics.Application;

public class DailyAnalysisDto
{
    public required PowerHistoryDto PowerHistory { get; init; }
    public required AnalyticsMetricsDto Metrics { get; init; }
}
