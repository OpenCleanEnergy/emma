using Vogen;

namespace OpenEMS.Domain;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct IntegrationId
{
    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid(
                $"{nameof(IntegrationId)} must not be null or empty or whitespace."
            )
            : Validation.Ok;
    }
}
