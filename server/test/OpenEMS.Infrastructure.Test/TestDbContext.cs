using Microsoft.EntityFrameworkCore;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Infrastructure.Persistence;
using Testcontainers.PostgreSql;

namespace OpenEMS.Infrastructure.Test;

public sealed class TestDbContext : AppDbContext
{
    private readonly PostgreSqlContainer? _container;
    private readonly string _connectionString;
    private readonly ICurrentUserReader _currentUserReader;

    private TestDbContext(PostgreSqlContainer container, ICurrentUserReader currentUserReader)
        : this(container.GetConnectionString(), currentUserReader)
    {
        _container = container;
    }

    private TestDbContext(string connectionString, ICurrentUserReader currentUserReader)
        : base(
            new DbContextOptionsBuilder<AppDbContext>().UseNpgsql(connectionString).Options,
            currentUserReader
        )
    {
        _connectionString = connectionString;
        _currentUserReader = currentUserReader;
    }

    public static async Task<TestDbContext> Start(ICurrentUserReader currentUserReader)
    {
        var container = new PostgreSqlBuilder().Build();
        await container.StartAsync();

        var dbContext = new TestDbContext(container, currentUserReader);
        await dbContext.Database.EnsureCreatedAsync();
        return dbContext;
    }

    public static TestDbContext FromExisting(TestDbContext existing)
    {
        return new TestDbContext(existing._connectionString, existing._currentUserReader);
    }

    public override void Dispose()
    {
        base.Dispose();
        _container?.DisposeAsync().AsTask().Wait();
    }

    public override async ValueTask DisposeAsync()
    {
        await base.DisposeAsync();
        if (_container is not null)
        {
            await _container.DisposeAsync();
        }
    }
}
