namespace OpenEMS.Infrastructure.Analytics;

public abstract class PostgreSqlDeviceSamplingSqlFactory : IDbContextDeviceSamplingSqlFactory
{
    public string GetSamplingSql(DateTimeOffset timestamp, Func<Type, string> tableNameProvider)
    {
        return GetSamplingSql($"'{timestamp.UtcDateTime:O}'", tableNameProvider);
    }

    protected abstract string GetSamplingSql(
        string timestampSqlValue,
        Func<Type, string> tableNameProvider
    );
}
