using Vogen;

namespace OpenEMS.Integrations.Shared.Credentials;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct Username
{
    private static Validation Validate(string value) =>
        string.IsNullOrEmpty(value)
            ? Validation.Invalid($"{nameof(Username)} cannot be empty.")
            : Validation.Ok;
}
