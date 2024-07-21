using Vogen;

namespace OpenEMS.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
[Instance("Relay", "relay")]
[Instance("EMeter", "emeter")]
public readonly partial record struct ShellyDeviceType
{
    private static string NormalizeInput(string input) => input.Trim().ToLowerInvariant();

    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid(
                $"{nameof(ShellyDeviceType)} must not be null or empty or whitespace."
            )
            : Validation.Ok;
    }
}
