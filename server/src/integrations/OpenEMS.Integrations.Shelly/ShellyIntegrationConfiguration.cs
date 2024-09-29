using System.ComponentModel.DataAnnotations;

namespace OpenEMS.Integrations.Shelly;

public class ShellyIntegrationConfiguration : IValidatableObject
{
    public bool IsEnabled { get; init; } = true;
    public required string IntegratorTag { get; init; }
    public required string IntegratorToken { get; init; }
    public required Uri CallbackBaseUrl { get; init; }

    public bool IsValid() => !Validate(new(this)).Any();

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (!IsEnabled)
        {
            yield break;
        }

        const string isRequired = "is required";

        if (string.IsNullOrEmpty(IntegratorTag))
        {
            yield return new ValidationResult(isRequired, [nameof(IntegratorTag)]);
        }

        if (string.IsNullOrEmpty(IntegratorToken))
        {
            yield return new ValidationResult(isRequired, [nameof(IntegratorToken)]);
        }

        if (CallbackBaseUrl is null)
        {
            yield return new ValidationResult(isRequired, [nameof(CallbackBaseUrl)]);
        }
    }
}
