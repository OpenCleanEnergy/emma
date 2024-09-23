using OpenEMS.Analytics;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Infrastructure.Analytics;

public class ProducerSamplingSqlFactory : PostgreSqlDeviceSamplingSqlFactory
{
    protected override string GetSamplingSql(
        string timestampSqlValue,
        Func<Type, string> tableNameProvider
    )
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
                {timestampSqlValue},
                "{nameof(Producer.CurrentPowerProduction)}",
                "{nameof(Producer.TotalEnergyProduction)}_{nameof(
                Producer.TotalEnergyProduction.Value
            )}",
                "{nameof(Producer.OwnedBy)}"
            FROM "{tableNameProvider(typeof(Producer))}"
            """;

        return sql;
    }
}
