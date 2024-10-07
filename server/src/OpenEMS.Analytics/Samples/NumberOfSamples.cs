using Vogen;

namespace OpenEMS.Analytics.Samples;

[ValueObject<int>]
public readonly partial record struct NumberOfSamples
{
    private static Validation Validate(int input)
    {
        return input >= 0
            ? Validation.Ok
            : Validation.Invalid("Expected a positive number of samples.");
    }
}
