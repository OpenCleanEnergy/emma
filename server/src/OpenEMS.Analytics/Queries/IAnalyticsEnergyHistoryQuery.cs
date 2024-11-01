namespace OpenEMS.Analytics.Queries;

public interface IAnalyticsEnergyHistoryQuery
{
    Task<EnergyHistory<TKey>> GetEnergyHistory<TKey>(
        IReadOnlyList<EnergyHistoryQueryInterval<TKey>> intervals
    )
        where TKey : notnull;
}
