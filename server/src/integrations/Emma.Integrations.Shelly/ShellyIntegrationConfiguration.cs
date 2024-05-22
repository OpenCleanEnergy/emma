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
    public bool IsValid =>
        !string.IsNullOrEmpty(IntegratorTag)
        && !string.IsNullOrEmpty(IntegratorToken)
        && CallbackBaseUri != null;
}
