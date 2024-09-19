using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics;

public abstract class PostgreSqlDeviceSamplingSqlFactory : IDbContextDeviceSamplingSqlFactory
{
    public string GetSamplingSql(AppDbContext context, DateTimeOffset timestamp)
    {
        return GetSamplingSql(context, $"'{timestamp.UtcDateTime:O}'");
    }

    protected abstract string GetSamplingSql(AppDbContext context, string timestampSqlValue);
}
