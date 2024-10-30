using OpenEMS.Analytics.Samples;
using OpenEMS.Domain.Meters;

namespace OpenEMS.Infrastructure.Analytics.Samples;

public class PostgreSqlElectricityMeterSamplingSqlFactory : IDbContextDeviceSamplingSqlFactory
{
    public string GetSamplingSql(Func<Type, string> tableNameProvider, string timestampParam)
    {
        var sql = $"""
            INSERT INTO "{tableNameProvider(typeof(ElectricityMeterSample))}" (
                "{nameof(ElectricityMeterSample.ElectricityMeterId)}",
                "{nameof(ElectricityMeterSample.Timestamp)}",
                "{nameof(ElectricityMeterSample.CurrentPower)}",
                "{nameof(ElectricityMeterSample.CurrentPowerDirection)}",
                "{nameof(ElectricityMeterSample.TotalEnergyConsumption)}",
                "{nameof(ElectricityMeterSample.TotalEnergyFeedIn)}",
                "{nameof(ElectricityMeterSample.OwnedBy)}"
            )
            SELECT
                "{nameof(ElectricityMeter.Id)}",
                {timestampParam},
                "{nameof(ElectricityMeter.CurrentPower)}",
                "{nameof(ElectricityMeter.CurrentPowerDirection)}",
                "{nameof(ElectricityMeter.TotalEnergyConsumption)}_{nameof(
                ElectricityMeter.TotalEnergyConsumption.Value
            )}",
                "{nameof(ElectricityMeter.TotalEnergyFeedIn)}_{nameof(
                ElectricityMeter.TotalEnergyFeedIn.Value
            )}",
                "{nameof(ElectricityMeter.OwnedBy)}"
            FROM "{tableNameProvider(typeof(ElectricityMeter))}";
            """;

        return sql;
    }
}
