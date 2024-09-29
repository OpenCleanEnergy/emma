using System.ComponentModel.DataAnnotations;

namespace OpenEMS.Analytics;

public class DeviceSamplerConfiguration : IValidatableObject
{
    public required TimeSpan SamplingInterval { get; init; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (SamplingInterval <= TimeSpan.Zero)
        {
            yield return new ValidationResult("must be greater 0", [nameof(SamplingInterval)]);
        }
    }
}
