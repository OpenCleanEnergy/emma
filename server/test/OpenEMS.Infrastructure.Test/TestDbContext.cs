using Microsoft.EntityFrameworkCore;
using Npgsql;
using NSubstitute;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Infrastructure.Persistence;
using Testcontainers.PostgreSql;

namespace OpenEMS.Infrastructure.Test;

public sealed class TestDbContext : AppDbContext
{
    private const string PostgreSqlImage = "postgres:15-alpine";
    private static readonly Lazy<Task<PostgreSqlContainer>> _lazyContainer =
        new(CreateStartedContainer);
    private static int _counter;

    private readonly string _connectionString;
    private readonly ICurrentUserReader _currentUserReader;

    private TestDbContext(string connectionString, ICurrentUserReader currentUserReader)
        : base(new DbContextOptionsBuilder().UseNpgsql(connectionString).Options, currentUserReader)
    {
        _connectionString = connectionString;
        _currentUserReader = currentUserReader;
    }

    public static async Task<TestDbContext> CreateNew(ICurrentUserReader? currentUserReader = null)
    {
        var container = await _lazyContainer.Value;

        var database = $"db{Interlocked.Increment(ref _counter)}";
        await container.ExecScriptAsync($"CREATE DATABASE {database}");

        var connectionStringBuilder = new NpgsqlConnectionStringBuilder(
            container.GetConnectionString()
        )
        {
            Database = database,
        };

        var dbContext = new TestDbContext(
            connectionStringBuilder.ConnectionString,
            currentUserReader ?? Substitute.For<ICurrentUserReader>()
        );

        await dbContext.Database.EnsureCreatedAsync();
        return dbContext;
    }

    public static TestDbContext FromExisting(
        TestDbContext existing,
        ICurrentUserReader? currentUserReader = null
    )
    {
        return new TestDbContext(
            existing._connectionString,
            currentUserReader ?? existing._currentUserReader
        );
    }

    private static async Task<PostgreSqlContainer> CreateStartedContainer()
    {
        var container = new PostgreSqlBuilder().WithImage(PostgreSqlImage).Build();
        await container.StartAsync();
        return container;
    }
}
