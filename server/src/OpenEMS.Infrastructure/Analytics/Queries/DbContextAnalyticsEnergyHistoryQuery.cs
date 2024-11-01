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
        IReadOnlyList<EnergyHistoryQueryParameter<TKey>> parameters
    )
        where TKey : notnull
    {
        // Switch consumers
        var switchConsumersQuery = parameters
            .Skip(1)
            .Aggregate(
                GetSwitchConsumerQuery(parameters[0]),
                (query, parameter) => query.Union(GetSwitchConsumerQuery(parameter))
            );

        var switchConsumers = await switchConsumersQuery
            .TagWith($"{nameof(GetEnergyHistory)}.{nameof(_context.SwitchConsumerSamples)}")
            .ToArrayAsync();

        var producersQuery = parameters
            .Skip(1)
            .Aggregate(
                GetProducerQuery(parameters[0]),
                (query, parameter) => query.Union(GetProducerQuery(parameter))
            );

        // Producers
        var producers = await producersQuery
            .TagWith($"{nameof(GetEnergyHistory)}.{nameof(_context.ProducerSamples)}")
            .ToArrayAsync();

        // Electricity meters - consumption
        var electricityMetersConsumptionQuery = parameters
            .Skip(1)
            .Aggregate(
                GetElectricityMeterConsumptionQuery(parameters[0]),
                (query, parameter) => query.Union(GetElectricityMeterConsumptionQuery(parameter))
            );

        var electricityMetersConsumption = await electricityMetersConsumptionQuery
            .TagWith(
                $"{nameof(GetEnergyHistory)}.{nameof(_context.ElectricityMeterSamples)}.Consumption"
            )
            .ToArrayAsync();

        // Electricity meters - feed in
        var electricityMetersFeedInQuery = parameters
            .Skip(1)
            .Aggregate(
                GetElectricityMeterFeedInQuery(parameters[0]),
                (query, parameter) => query.Union(GetElectricityMeterFeedInQuery(parameter))
            );

        var electricityMetersFeedIn = await electricityMetersFeedInQuery
            .TagWith(
                $"{nameof(GetEnergyHistory)}.{nameof(_context.ElectricityMeterSamples)}.FeedIn"
            )
            .ToArrayAsync();

        return new EnergyHistory<TKey>
        {
            Consumers = GetEnergyDataPoints(parameters, switchConsumers),
            Producers = GetEnergyDataPoints(parameters, producers),
            ElectricityMetersConsumption = GetEnergyDataPoints(
                parameters,
                electricityMetersConsumption
            ),
            ElectricityMetersFeedIn = GetEnergyDataPoints(parameters, electricityMetersFeedIn),
        };
    }

    private static IReadOnlyList<EnergyDataPoint<TKey>> GetEnergyDataPoints<TKey>(
        IReadOnlyList<EnergyHistoryQueryParameter<TKey>> parameters,
        IReadOnlyList<RawEnergyDataPoint<TKey>> dataPoints
    )
        where TKey : notnull
    {
        var energyByKey = dataPoints
            .GroupBy(dataPoint => dataPoint.Key)
            .ToDictionary(group => group.Key, group => group.Sum(_ => _.Energy));

        return
        [
            .. parameters
                .Where(parameter => energyByKey.ContainsKey(parameter.Key))
                .Select(parameter => new EnergyDataPoint<TKey>(
                    parameter.Key,
                    energyByKey[parameter.Key]
                )),
        ];
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetSwitchConsumerQuery<TKey>(
        EnergyHistoryQueryParameter<TKey> parameter
    )
    {
        return from sample in _context.SwitchConsumerSamples
            where
                sample.Timestamp >= parameter.Start
                && sample.Timestamp <= parameter.End
                && sample.TotalEnergyConsumption != null
            group sample by sample.SwitchConsumerId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = parameter.Key,
                Energy =
                    g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetProducerQuery<TKey>(
        EnergyHistoryQueryParameter<TKey> parameter
    )
    {
        return from sample in _context.ProducerSamples
            where
                sample.Timestamp >= parameter.Start
                && sample.Timestamp <= parameter.End
                && sample.TotalEnergyProduction != null
            group sample by sample.ProducerId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = parameter.Key,
                Energy = g.Max(_ => _.TotalEnergyProduction) - g.Min(_ => _.TotalEnergyProduction),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetElectricityMeterConsumptionQuery<TKey>(
        EnergyHistoryQueryParameter<TKey> parameter
    )
    {
        return from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= parameter.Start
                && sample.Timestamp <= parameter.End
                && sample.TotalEnergyConsumption != null
            group sample by sample.ElectricityMeterId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = parameter.Key,
                Energy =
                    g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption),
            };
    }

    private IQueryable<RawEnergyDataPoint<TKey>> GetElectricityMeterFeedInQuery<TKey>(
        EnergyHistoryQueryParameter<TKey> parameter
    )
    {
        return from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= parameter.Start
                && sample.Timestamp <= parameter.End
                && sample.TotalEnergyFeedIn != null
            group sample by sample.ElectricityMeterId into g
            select new RawEnergyDataPoint<TKey>
            {
                Key = parameter.Key,
                Energy = g.Max(_ => _.TotalEnergyFeedIn) - g.Min(_ => _.TotalEnergyFeedIn),
            };
    }

    private sealed class RawEnergyDataPoint<TKey>
    {
        public required TKey Key { get; init; }
        public required WattHours? Energy { get; init; }
    }
}
