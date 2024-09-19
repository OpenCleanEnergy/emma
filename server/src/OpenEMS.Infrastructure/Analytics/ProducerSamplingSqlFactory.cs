using OpenEMS.Analytics;
using OpenEMS.Domain.Producers;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics;

public class ProducerSamplingSqlFactory : PostgreSqlDeviceSamplingSqlFactory
{
    protected override string GetSamplingSql(AppDbContext context, string timestampSqlValue)
    {
        var sql = $"""
            INSERT INTO "{nameof(context.ProducerSamples)}" (
                "{nameof(ProducerSample.ProducerId)}",
                "{nameof(ProducerSample.Timestamp)}",
                "{nameof(ProducerSample.CurrentPowerProduction)}",
                "{nameof(ProducerSample.TotalEnergyProduction)}",
                "{nameof(ProducerSample.OwnedBy)}"
            )
            SELECT
                "{nameof(Producer.Id)}",
                {timestampSqlValue},
                "{nameof(Producer.CurrentPowerProduction)}",
                "{nameof(Producer.TotalEnergyProduction)}_{nameof(
                Producer.TotalEnergyProduction.Value
            )}",
                "{nameof(Producer.OwnedBy)}"
            FROM "{nameof(context.Producers)}"
            """;

        return sql;
    }
}
