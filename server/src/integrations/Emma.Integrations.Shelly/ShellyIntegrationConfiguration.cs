using System.Diagnostics.CodeAnalysis;

namespace Emma.Integrations.Shelly;

public class ShellyIntegrationConfiguration
{
    public string? IntegratorTag { get; init; }
    public string? IntegratorToken { get; init; }
    public Uri? CallbackBaseUri { get; init; }

    [MemberNotNullWhen(true, nameof(IntegratorTag))]
    [MemberNotNullWhen(true, nameof(IntegratorToken))]
    [MemberNotNullWhen(true, nameof(CallbackBaseUri))]
    public bool Validate(out IReadOnlyCollection<string> invalidProperties)
    {
        var invalid = new List<string>();

        if (string.IsNullOrEmpty(IntegratorTag))
        {
            invalid.Add(nameof(IntegratorTag));
        }

        if (string.IsNullOrEmpty(IntegratorToken))
        {
            invalid.Add(nameof(IntegratorToken));
        }

        if (CallbackBaseUri is null)
        {
            invalid.Add(nameof(CallbackBaseUri));
        }

        invalidProperties = invalid;
        return invalid.Count == 0;
    }
}
