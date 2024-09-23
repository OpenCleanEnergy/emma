using System.Text;
using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics;

public class DbContextDeviceSampler(
    AppDbContext context,
    IEnumerable<IDbContextDeviceSamplingSqlFactory> sqlFactories
) : IDeviceSampler
{
    private readonly AppDbContext _context = context;
    private readonly IEnumerable<IDbContextDeviceSamplingSqlFactory> _sqlFactories = sqlFactories;

    public async Task<NumberOfSamples> TakeSamples(DateTimeOffset timestamp)
    {
        var sb = new StringBuilder();
        foreach (var factory in _sqlFactories)
        {
            sb.AppendLine(factory.GetSamplingSql(timestamp, GetTableName));
        }

        var count = await _context.Database.ExecuteSqlRawAsync(sb.ToString());

        return NumberOfSamples.From(count);
    }

    private string GetTableName(Type entityType)
    {
        var entityTypeModel =
            _context.Model.FindEntityType(entityType)
            ?? throw new InvalidOperationException($"Entity type {entityType} not found in model.");

        return entityTypeModel.GetTableName()
            ?? throw new InvalidOperationException($"Entity type {entityType} has no table name.");
    }
}
