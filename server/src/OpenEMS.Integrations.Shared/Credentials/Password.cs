using Vogen;

namespace OpenEMS.Integrations.Shared.Credentials;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct Password
{
    private static Validation Validate(string value) =>
        string.IsNullOrEmpty(value)
            ? Validation.Invalid($"{nameof(Password)} cannot be empty.")
            : Validation.Ok;
}
