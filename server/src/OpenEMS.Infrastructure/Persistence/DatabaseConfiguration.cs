using System.ComponentModel.DataAnnotations;
using Npgsql;

namespace OpenEMS.Infrastructure.Persistence;

public class DatabaseConfiguration : IValidatableObject
{
    public required string Host { get; init; }
    public required string Database { get; init; }
    public required string Username { get; init; }
    public required string Password { get; init; }
    public bool SslRequired { get; init; } = true;

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

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        const string isRequired = "is required";

        if (string.IsNullOrEmpty(Host))
        {
            yield return new ValidationResult(isRequired, [nameof(Host)]);
        }

        if (string.IsNullOrEmpty(Database))
        {
            yield return new ValidationResult(isRequired, [nameof(Database)]);
        }

        if (string.IsNullOrEmpty(Username))
        {
            yield return new ValidationResult(isRequired, [nameof(Username)]);
        }

        if (string.IsNullOrEmpty(Password))
        {
            yield return new ValidationResult(isRequired, [nameof(Password)]);
        }
    }
}
