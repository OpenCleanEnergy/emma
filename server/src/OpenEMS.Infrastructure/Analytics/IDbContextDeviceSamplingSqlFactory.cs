namespace OpenEMS.Infrastructure.Analytics;

public interface IDbContextDeviceSamplingSqlFactory
{
    string GetSamplingSql(DateTimeOffset timestamp, Func<Type, string> tableNameProvider);
}
