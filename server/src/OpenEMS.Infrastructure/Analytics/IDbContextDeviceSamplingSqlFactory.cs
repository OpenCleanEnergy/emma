using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics;

public interface IDbContextDeviceSamplingSqlFactory
{
    string GetSamplingSql(AppDbContext context, DateTimeOffset timestamp);
}
