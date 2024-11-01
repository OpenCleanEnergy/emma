using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics.Queries;

public class DbContextAnalyticsEnergyHistoryQuery(AppDbContext context)
    : IAnalyticsEnergyHistoryQuery
{
    private readonly AppDbContext _context = context;

    public async Task<EnergyHistory<TKey>> GetEnergyHistory<TKey>(
        IReadOnlyList<EnergyHistoryQueryInterval<TKey>> intervals
    )
        where TKey : notnull
    {
        // Switch consumers
        var switchConsumersQuery = intervals
            .Skip(1)
            .Aggregate(
                GetSwitchConsumerQuery(intervals[0]),
                (query, interval) => query.Union(GetSwitchConsumerQuery(interval))
            );

        var switchConsumers = await switchConsumersQuery
            .TagWith($"{nameof(GetEnergyHistory)}.{nameof(_context.SwitchConsumerSamples)}")
            .ToArrayAsync();

        var producersQuery = intervals
            .Skip(1)
            .Aggregate(
                GetProducerQuery(intervals[0]),
                (query, interval) => query.Union(GetProducerQuery(interval))
            );

        // Producers
        var producers = await producersQuery
            .TagWith($"{nameof(GetEnergyHistory)}.{nameof(_context.ProducerSamples)}")
            .ToArrayAsync();

        // Electricity meters - consumption
        var electricityMetersConsumptionQuery = intervals
            .Skip(1)
            .Aggregate(
                GetElectricityMeterConsumptionQuery(intervals[0]),
                (query, interval) => query.Union(GetElectricityMeterConsumptionQuery(interval))
            );

        var electricityMetersConsumption = await electricityMetersConsumptionQuery
            .TagWith(
                $"{nameof(GetEnergyHistory)}.{nameof(_context.ElectricityMeterSamples)}.Consumption"
            )
            .ToArrayAsync();

        // Electricity meters - feed in
        var electricityMetersFeedInQuery = intervals
            .Skip(1)
            .Aggregate(
                GetElectricityMeterFeedInQuery(intervals[0]),
                (query, interval) => query.Union(GetElectricityMeterFeedInQuery(interval))
            );

        var electricityMetersFeedIn = await electricityMetersFeedInQuery
            .TagWith(
                $"{nameof(GetEnergyHistory)}.{nameof(_context.ElectricityMeterSamples)}.FeedIn"
            )
            .ToArrayAsync();

        return new EnergyHistory<TKey>
        {
            Consumers = GetEnergyDataPoints(intervals, switchConsumers),
            Producers = GetEnergyDataPoints(intervals, producers),
            ElectricityMetersConsumption = GetEnergyDataPoints(
                intervals,
                electricityMetersConsumption
            ),
            ElectricityMetersFeedIn = GetEnergyDataPoints(intervals, electricityMetersFeedIn),
        };
    }

    private static EnergyDataPoint<TKey>[] GetEnergyDataPoints<TKey>(
        IReadOnlyList<EnergyHistoryQueryInterval<TKey>> intervals,
        IReadOnlyList<RawEnergyDataPoint<TKey>> dataPoints
    )
        where TKey : notnull
    {
        var energyByKey = dataPoints
            .GroupBy(dataPoint => dataPoint.Key)
            .ToDictionary(group => group.Key, group => group.Sum(_ => _.Energy));

        return intervals
            .Where(interval => energyByKey.ContainsKey(interval.Key))
            .Select(interval => new EnergyDataPoint<TKey>(interval.Key, energyByKey[interval.Key]))
            .ToArray();
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetSwitchConsumerQuery<TKey>(
        EnergyHistoryQueryInterval<TKey> interval
    )
    {
        return from sample in _context.SwitchConsumerSamples
            where
                sample.Timestamp >= interval.Start
                && sample.Timestamp <= interval.End
                && sample.TotalEnergyConsumption != null
            group sample by sample.SwitchConsumerId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = interval.Key,
                Energy =
                    g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetProducerQuery<TKey>(
        EnergyHistoryQueryInterval<TKey> interval
    )
    {
        return from sample in _context.ProducerSamples
            where
                sample.Timestamp >= interval.Start
                && sample.Timestamp <= interval.End
                && sample.TotalEnergyProduction != null
            group sample by sample.ProducerId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = interval.Key,
                Energy = g.Max(_ => _.TotalEnergyProduction) - g.Min(_ => _.TotalEnergyProduction),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetElectricityMeterConsumptionQuery<TKey>(
        EnergyHistoryQueryInterval<TKey> interval
    )
    {
        return from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= interval.Start
                && sample.Timestamp <= interval.End
                && sample.TotalEnergyConsumption != null
            group sample by sample.ElectricityMeterId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = interval.Key,
                Energy =
                    g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetElectricityMeterFeedInQuery<TKey>(
        EnergyHistoryQueryInterval<TKey> interval
    )
    {
        return from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= interval.Start
                && sample.Timestamp <= interval.End
                && sample.TotalEnergyFeedIn != null
            group sample by sample.ElectricityMeterId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = interval.Key,
                Energy = g.Max(_ => _.TotalEnergyFeedIn) - g.Min(_ => _.TotalEnergyFeedIn),
            };
    }

    private sealed class RawEnergyDataPoint<TKey>
    {
        public required TKey Key { get; init; }
        public required WattHours? Energy { get; init; }
    }
}
