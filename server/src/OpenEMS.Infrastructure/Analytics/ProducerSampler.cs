using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics;
using OpenEMS.Domain.Producers;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics;

public class ProducerSampler(AppDbContext dbContext) : IDeviceSampler
{
    private readonly AppDbContext _dbContext = dbContext;

    public async Task<NumberOfSamples> TakeSample(DateTimeOffset timestamp)
    {
        var sql = $"""
            INSERT INTO "{nameof(_dbContext.ProducerHistory)}" (
                "{nameof(ProducerHistoryEntry.ProducerId)}",
                "{nameof(ProducerHistoryEntry.Timestamp)}",
                "{nameof(ProducerHistoryEntry.CurrentPowerProduction)}",
                "{nameof(ProducerHistoryEntry.MaximumPowerProduction)}",
                "{nameof(ProducerHistoryEntry.TotalEnergyProduction)}",
                "{nameof(ProducerHistoryEntry.OwnedBy)}"
            )
            SELECT
                "{nameof(Producer.Id)}",
                '{timestamp.UtcDateTime:O}',
                "{nameof(Producer.CurrentPowerProduction)}",
                "{nameof(Producer.MaximumPowerProduction)}",
                "{nameof(Producer.TotalEnergyProduction)}_{nameof(
                Producer.TotalEnergyProduction.Value
            )}",
                "{nameof(Producer.OwnedBy)}"
            FROM "{nameof(_dbContext.Producers)}"
            """;

        var count = await _dbContext.Database.ExecuteSqlRawAsync(sql);

        return NumberOfSamples.From(count);
    }
}
