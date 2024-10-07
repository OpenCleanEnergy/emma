using OpenEMS.Analytics.Samples;
using OpenEMS.Domain.Consumers;

namespace OpenEMS.Infrastructure.Analytics.Samples;

public class PostgreSqlSwitchConsumerSamplingSqlFactory : IDbContextDeviceSamplingSqlFactory
{
    public string GetSamplingSql(Func<Type, string> tableNameProvider, string timestampParam)
    {
        var sql = $"""
            INSERT INTO "{tableNameProvider(typeof(SwitchConsumerSample))}" (
                "{nameof(SwitchConsumerSample.SwitchConsumerId)}",
                "{nameof(SwitchConsumerSample.Timestamp)}",
                "{nameof(SwitchConsumerSample.CurrentPowerConsumption)}",
                "{nameof(SwitchConsumerSample.TotalEnergyConsumption)}",
                "{nameof(SwitchConsumerSample.OwnedBy)}"
            )
            SELECT
                "{nameof(SwitchConsumer.Id)}",
                {timestampParam},
                "{nameof(SwitchConsumer.CurrentPowerConsumption)}",
                "{nameof(SwitchConsumer.TotalEnergyConsumption)}_{nameof(
                SwitchConsumer.TotalEnergyConsumption.Value
            )}",
                "{nameof(SwitchConsumer.OwnedBy)}"
            FROM "{tableNameProvider(typeof(SwitchConsumer))}";
            """;

        return sql;
    }
}
