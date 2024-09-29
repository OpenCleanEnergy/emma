using System.ComponentModel.DataAnnotations;

namespace OpenEMS.Infrastructure.Events.CAP;

public class CapRabbitMQConfiguration : IValidatableObject
{
    public string ExchangeName { get; init; } = "openems.default.topic";
    public required Uri Url { get; init; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        const string isRequired = "is required";

        if (string.IsNullOrEmpty(ExchangeName))
        {
            yield return new ValidationResult(isRequired, [nameof(ExchangeName)]);
        }

        if (Url is null)
        {
            yield return new ValidationResult(isRequired, [nameof(Url)]);
        }
    }
}
