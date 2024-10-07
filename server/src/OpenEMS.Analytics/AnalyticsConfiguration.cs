using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Samples;

namespace OpenEMS.Analytics;

public class AnalyticsConfiguration : IValidatableObject
{
    public required DeviceSamplerConfiguration Sampling { get; init; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Sampling is null)
        {
            return [new ValidationResult("is required", [nameof(Sampling)])];
        }

        return Sampling
            .Validate(new(Sampling))
            .Select(result => new ValidationResult(
                result.ErrorMessage,
                result.MemberNames.Select(member => $"{nameof(Sampling)}.{member}")
            ));
    }
}
