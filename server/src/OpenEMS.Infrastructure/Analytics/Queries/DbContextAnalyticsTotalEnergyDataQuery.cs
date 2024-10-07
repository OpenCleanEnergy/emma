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
        var productionPerProducer =
            from sample in _context.ProducerSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyProduction != null
            group sample by sample.ProducerId into g
            select g.Max(_ => _.TotalEnergyProduction) - g.Min(_ => _.TotalEnergyProduction);

        var gridConsumptionPerMeter =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyConsumption != null
            group sample by sample.ElectricityMeterId into g
            select g.Max(_ => _.TotalEnergyConsumption) - g.Min(_ => _.TotalEnergyConsumption);

        var gridFeedInPerMeter =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.TotalEnergyFeedIn != null
            group sample by sample.ElectricityMeterId into g
            select g.Max(_ => _.TotalEnergyFeedIn) - g.Min(_ => _.TotalEnergyFeedIn);

        return new TotalEnergyData
        {
            TotalEnergyProduction = WattHours.From(
                await productionPerProducer.SumAsync(_ => _.GetValueOrDefault(WattHours.Zero).Value)
            ),
            TotalGridEnergyConsumption = WattHours.From(
                await gridConsumptionPerMeter.SumAsync(_ =>
                    _.GetValueOrDefault(WattHours.Zero).Value
                )
            ),
            TotalGridEnergyFeedIn = WattHours.From(
                await gridFeedInPerMeter.SumAsync(_ => _.GetValueOrDefault(WattHours.Zero).Value)
            ),
        };
    }
}
