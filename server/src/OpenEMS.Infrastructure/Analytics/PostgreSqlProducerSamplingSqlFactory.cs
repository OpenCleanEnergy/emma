using OpenEMS.Analytics;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Infrastructure.Analytics;

public class PostgreSqlProducerSamplingSqlFactory : IDbContextDeviceSamplingSqlFactory
{
    public string GetSamplingSql(Func<Type, string> tableNameProvider, string timestampParam)
    {
        var sql = $"""
            INSERT INTO "{tableNameProvider(typeof(ProducerSample))}" (
                "{nameof(ProducerSample.ProducerId)}",
                "{nameof(ProducerSample.Timestamp)}",
                "{nameof(ProducerSample.CurrentPowerProduction)}",
                "{nameof(ProducerSample.TotalEnergyProduction)}",
                "{nameof(ProducerSample.OwnedBy)}"
            )
            SELECT
                "{nameof(Producer.Id)}",
                {timestampParam},
                "{nameof(Producer.CurrentPowerProduction)}",
                "{nameof(Producer.TotalEnergyProduction)}_{nameof(
                Producer.TotalEnergyProduction.Value
            )}",
                "{nameof(Producer.OwnedBy)}"
            FROM "{tableNameProvider(typeof(Producer))}";
            """;

        return sql;
    }
}
