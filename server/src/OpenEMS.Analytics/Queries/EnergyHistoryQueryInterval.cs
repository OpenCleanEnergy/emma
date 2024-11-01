namespace OpenEMS.Analytics.Queries;

public class EnergyHistoryQueryInterval<TKey>
{
    public required TKey Key { get; init; }
    public required DateTimeOffset Start { get; init; }
    public required DateTimeOffset End { get; init; }
}
