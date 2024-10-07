namespace OpenEMS.Analytics.Queries;

public interface IAnalyticsDayDataQuery
{
    Task<DayData> QueryDayData(DateTimeOffset start, DateTimeOffset end, TimeSpan stride);
}
