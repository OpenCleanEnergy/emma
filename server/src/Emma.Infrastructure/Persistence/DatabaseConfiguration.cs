using Npgsql;

namespace Emma.Infrastructure.Persistence;

public class DatabaseConfiguration
{
    public required string Host { get; init; }
    public required string Database { get; init; }
    public required string Username { get; init; }
    public required string Password { get; init; }
    public bool SslRequired { get; init; }

    public string GetConnectionString()
    {
        var builder = new NpgsqlConnectionStringBuilder
        {
            Host = Host,
            Database = Database,
            Username = Username,
            Password = Password,
        };

        if (SslRequired)
        {
            builder.SslMode = SslMode.Require;
        }

        return builder.ConnectionString;
    }
}
