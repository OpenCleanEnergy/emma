using System.Diagnostics.CodeAnalysis;

namespace OpenEMS.Integrations.Shelly;

public class ShellyIntegrationConfiguration
{
    public bool IsEnabled { get; init; } = true;
    public string? IntegratorTag { get; init; }
    public string? IntegratorToken { get; init; }
    public Uri? CallbackBaseUrl { get; init; }

    [MemberNotNullWhen(true, nameof(IntegratorTag))]
    [MemberNotNullWhen(true, nameof(IntegratorToken))]
    [MemberNotNullWhen(true, nameof(CallbackBaseUrl))]
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

        if (CallbackBaseUrl is null)
        {
            invalid.Add(nameof(CallbackBaseUrl));
        }

        invalidProperties = invalid;
        return invalid.Count == 0;
    }
}
