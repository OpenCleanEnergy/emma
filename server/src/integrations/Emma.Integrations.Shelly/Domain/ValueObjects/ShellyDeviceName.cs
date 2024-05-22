using Emma.Domain;
using Vogen;

namespace Emma.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct ShellyDeviceName
{
    public DeviceName ToDeviceName() => DeviceName.From(Value);

    private static string NormalizeInput(string input) => input.Trim();

    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid(
                $"{nameof(ShellyDeviceName)} must not be null or empty or whitespace."
            )
            : Validation.Ok;
    }
}
