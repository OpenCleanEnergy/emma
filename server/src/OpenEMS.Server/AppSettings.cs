using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics;
using OpenEMS.Infrastructure.Events.CAP;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Server.Configuration;
using OpenEMS.Server.Integrations;

namespace OpenEMS.Server;

public class AppSettings
{
    public required KeycloakConfiguration Keycloak { get; init; }
    public required CapConfiguration Events { get; init; }
    public required DatabaseConfiguration Database { get; init; }
    public required AnalyticsConfiguration Analytics { get; init; }
    public required IntegrationsConfiguration Integrations { get; init; }

    public void Validate()
    {
        var validationResults = new List<ValidationResult>();

        var properties = GetType().GetProperties();

        var nullProperties = properties
            .Where(p => p.GetValue(this) is null)
            .Select(p => p.Name)
            .ToArray();

        if (nullProperties.Length > 0)
        {
            validationResults.Add(new ValidationResult("is required", nullProperties));
        }

        var validatableProperties = properties
            .Where(p => p.PropertyType.IsAssignableTo(typeof(IValidatableObject)))
            .Select(p => (Name: p.Name, Value: p.GetValue(this) as IValidatableObject))
            .Where(x => x.Value is not null)
            .ToArray();

        foreach (var (name, value) in validatableProperties)
        {
            var context = new ValidationContext(value!);
            var results = value!.Validate(context);
            validationResults.AddRange(
                results.Select(result => new ValidationResult(
                    result.ErrorMessage,
                    result.MemberNames.Select(member => $"{name}.{member}")
                ))
            );
        }

        if (validationResults.Count > 0)
        {
            var errors =
                from result in validationResults
                from member in result.MemberNames
                select $"{member}: {result.ErrorMessage}";

            throw new ValidationException(string.Join(Environment.NewLine, errors));
        }
    }
}
