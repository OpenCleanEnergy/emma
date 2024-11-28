using OpenEMS.Domain;

namespace OpenEMS.Integrations.Shared.Credentials;

public record BasicAuthCredentials : IHasOwner
{
    public required IntegrationId Integration { get; init; }
    public required Username Username { get; init; }
    public required Password Password { get; init; }
    public required UserId OwnedBy { get; init; }
}
