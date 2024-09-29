using System.ComponentModel.DataAnnotations;

namespace OpenEMS.Infrastructure.Events.CAP;

public class CapConfiguration : IValidatableObject
{
    public required CapRabbitMQConfiguration RabbitMQ { get; init; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (RabbitMQ is null)
        {
            return [new ValidationResult("is required", [nameof(RabbitMQ)])];
        }

        return RabbitMQ
            .Validate(new(RabbitMQ))
            .Select(result => new ValidationResult(
                result.ErrorMessage,
                result.MemberNames.Select(member => $"{nameof(RabbitMQ)}.{member}")
            ));
    }
}
