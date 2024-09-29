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

        var properties = GetType().GetProperties().Select(p => (p.Name, Value: p.GetValue(this)));

        foreach (var (name, value) in properties)
        {
            if (value is null)
            {
                validationResults.Add(new ValidationResult("is required", [name]));
            }
            else if (value is IValidatableObject validatable)
            {
                var context = new ValidationContext(validatable);
                var results = validatable.Validate(context);
                validationResults.AddRange(
                    results.Select(result => new ValidationResult(
                        result.ErrorMessage,
                        result.MemberNames.Select(member => $"{name}.{member}")
                    ))
                );
            }
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
