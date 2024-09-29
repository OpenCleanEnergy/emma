using System.ComponentModel.DataAnnotations;
using OpenEMS.Integrations.Shelly;

namespace OpenEMS.Server.Integrations;

public class IntegrationsConfiguration : IValidatableObject
{
    public required ShellyIntegrationConfiguration Shelly { get; init; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Shelly is null)
        {
            return [new ValidationResult("is required", [nameof(Shelly)])];
        }

        return Shelly
            .Validate(new(Shelly))
            .Select(result => new ValidationResult(
                result.ErrorMessage,
                result.MemberNames.Select(member => $"{nameof(Shelly)}.{member}")
            ));
    }
}
