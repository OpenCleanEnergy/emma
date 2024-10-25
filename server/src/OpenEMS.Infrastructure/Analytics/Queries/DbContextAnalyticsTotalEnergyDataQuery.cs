using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics.Queries;

public class DbContextAnalyticsTotalEnergyDataQuery(AppDbContext context)
    : IAnalyticsTotalEnergyDataQuery
{
    private readonly AppDbContext _context = context;

    public async Task<TotalEnergyData> QueryTotalEnergyData(
        DateTimeOffset start,
        DateTimeOffset end
    )
    {
        var productionPerProducerQuery =
            from sample in _context.ProducerSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyProduction != null
            group sample by sample.ProducerId into g
            select g.Max(_ => _.TotalEnergyProduction) - g.Min(_ => _.TotalEnergyProduction);

        var productionPerProducer = await productionPerProducerQuery
            .TagWith($"{nameof(QueryTotalEnergyData)}.{nameof(_context.ProducerSamples)}")
            .ToArrayAsync();

        var gridConsumptionPerMeterQuery =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyConsumption != null
            group sample by sample.ElectricityMeterId into g
            select g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption);

        var gridConsumptionPerMeter = await gridConsumptionPerMeterQuery
            .TagWith(
                $"{nameof(QueryTotalEnergyData)}.{nameof(_context.ElectricityMeterSamples)}.Consumption"
            )
            .ToArrayAsync();

        var gridFeedInPerMeterQuery =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyFeedIn != null
            group sample by sample.ElectricityMeterId into g
            select g.Max(_ => _.TotalEnergyFeedIn) - g.Min(_ => _.TotalEnergyFeedIn);

        var gridFeedInPerMeter = await gridFeedInPerMeterQuery
            .TagWith(
                $"{nameof(QueryTotalEnergyData)}.{nameof(_context.ElectricityMeterSamples)}.FeedIn"
            )
            .ToArrayAsync();

        return new TotalEnergyData
        {
            TotalEnergyProduction = productionPerProducer.Sum(),
            TotalGridEnergyConsumption = gridConsumptionPerMeter.Sum(),
            TotalGridEnergyFeedIn = gridFeedInPerMeter.Sum(),
        };
    }
}
