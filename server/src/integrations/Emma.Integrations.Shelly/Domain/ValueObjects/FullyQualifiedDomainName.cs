using Vogen;

namespace Emma.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct FullyQualifiedDomainName
{
    private static string NormalizeInput(string input) => input.Trim().TrimEnd('/');

    private static Validation Validate(string input)
    {
        return Uri.TryCreate($"http://{input}", default, out _)
            ? Validation.Ok
            : Validation.Invalid($"'{input}' is not a valid FQDN.");
    }
}
