using OpenEMS.Domain;
using OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

namespace OpenEMS.Infrastructure.Integrations.Shared.Credentials;

public class EncryptedBasicAuthCredentials
{
    public required IntegrationId Integration { get; init; }
    public required UserId OwnedBy { get; init; }
    public required AesGcmEncryptionResult Username { get; set; }
    public required AesGcmEncryptionResult Password { get; set; }
}
