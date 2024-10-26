namespace OpenEMS.Analytics.Queries;

public interface IAnalyticsPowerHistoryQuery
{
    Task<PowerHistory> GetPowerHistory(DateTimeOffset start, DateTimeOffset end, TimeSpan stride);
}
