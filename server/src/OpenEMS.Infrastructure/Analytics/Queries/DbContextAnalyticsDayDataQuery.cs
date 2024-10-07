using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics.Queries;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics.Queries;

public class DbContextAnalyticsDayDataQuery(AppDbContext context) : IAnalyticsDayDataQuery
{
    private readonly AppDbContext _context = context;

    public async Task<DayData> QueryDayData(
        DateTimeOffset start,
        DateTimeOffset end,
        TimeSpan stride
    )
    {
        var consumers =
            from sample in _context.SwitchConsumerSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.CurrentPowerConsumption != null
            group sample by sample.Timestamp into g
            orderby g.Key
            select new PowerDataPoint(
                g.Key,
                Watt.From(g.Sum(s => s.CurrentPowerConsumption!.Value.Value))
            );

        var producers =
            from sample in _context.ProducerSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.CurrentPowerProduction != null
            group sample by sample.Timestamp into g
            orderby g.Key
            select new PowerDataPoint(
                g.Key,
                Watt.From(g.Sum(s => s.CurrentPowerProduction!.Value.Value))
            );

        var electricityMetersConsume =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.CurrentPower != null
                && new[] { GridPowerDirection.None, GridPowerDirection.Consume }.Contains(
                    sample.CurrentPowerDirection
                )
            group sample by sample.Timestamp into g
            orderby g.Key
            select new PowerDataPoint(g.Key, Watt.From(g.Sum(s => s.CurrentPower!.Value.Value)));

        var electricityMetersFeedIn =
            from sample in _context.ElectricityMeterSamples
            where
                sample.Timestamp >= start
                && sample.Timestamp <= end
                && sample.CurrentPower != null
                && new[] { GridPowerDirection.None, GridPowerDirection.FeedIn }.Contains(
                    sample.CurrentPowerDirection
                )
            group sample by sample.Timestamp into g
            orderby g.Key
            select new PowerDataPoint(g.Key, Watt.From(g.Sum(s => s.CurrentPower!.Value.Value)));

        return new DayData
        {
            Consumers = await DateBinAverage(stride, consumers),
            Producers = await DateBinAverage(stride, producers),
            ElectricityMetersConsume = await DateBinAverage(stride, electricityMetersConsume),
            ElectricityMetersFeedIn = await DateBinAverage(stride, electricityMetersFeedIn),
        };
    }

    private static async Task<PowerDataPoint[]> DateBinAverage(
        TimeSpan stride,
        IQueryable<PowerDataPoint> dataPointsQuery
    )
    {
        var query =
            from dataPoint in await dataPointsQuery.ToArrayAsync()
            group dataPoint by DateBin(stride, dataPoint.Timestamp) into g
            orderby g.Key
            select new PowerDataPoint(g.Key, Watt.From(g.Average(s => s.Power.Value)));

        return [.. query];
    }

    // https://www.postgresql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-BIN
    private static DateTimeOffset DateBin(TimeSpan stride, DateTimeOffset source)
    {
        var sourceTicks = source.Ticks;
        var strideTicks = stride.Ticks;

        var remainder = sourceTicks % strideTicks;
        if (remainder == 0)
        {
            return source;
        }

        var ticksToAdd = strideTicks - remainder;
        return source.AddTicks(ticksToAdd);
    }
}
