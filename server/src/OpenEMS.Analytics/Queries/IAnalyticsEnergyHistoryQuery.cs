namespace OpenEMS.Analytics.Queries;

public interface IAnalyticsEnergyHistoryQuery
{
    Task<EnergyHistory<TKey>> GetEnergyHistory<TKey>(
        IReadOnlyList<EnergyHistoryQueryParameter<TKey>> parameters
    )
        where TKey : notnull;
}
