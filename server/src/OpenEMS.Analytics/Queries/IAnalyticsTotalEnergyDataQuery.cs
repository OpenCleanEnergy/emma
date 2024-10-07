namespace OpenEMS.Analytics.Queries;

public interface IAnalyticsTotalEnergyDataQuery
{
    Task<TotalEnergyData> QueryTotalEnergyData(DateTimeOffset start, DateTimeOffset end);
}
