namespace OpenEMS.Infrastructure.Analytics;

public interface IDbContextDeviceSamplingSqlFactory
{
    string GetSamplingSql(Func<Type, string> tableNameProvider, string timestampParam);
}
