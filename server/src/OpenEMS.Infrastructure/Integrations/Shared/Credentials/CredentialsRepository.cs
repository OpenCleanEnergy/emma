using Microsoft.EntityFrameworkCore;
using OpenEMS.Domain;
using OpenEMS.Infrastructure.Integrations.Shared.Cryptography;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Integrations.Shared.Credentials;

namespace OpenEMS.Infrastructure.Integrations.Shared.Credentials;

public class CredentialsRepository(AppDbContext context, AesGcmEncryption encryption)
    : ICredentialsRepository
{
    private readonly AppDbContext _context = context;
    private readonly AesGcmEncryption _encryption = encryption;

    public void Add(BasicAuthCredentials credentials)
    {
        var encrypted = new EncryptedBasicAuthCredentials
        {
            Integration = credentials.Integration,
            OwnedBy = credentials.OwnedBy,
            Username = _encryption.Encrypt(credentials.Username.Value),
            Password = _encryption.Encrypt(credentials.Password.Value),
        };

        _context.BasicAuthCredentials.Add(encrypted);
    }

    public async Task<BasicAuthCredentials?> FindBasicAuthCredentials(IntegrationId integration)
    {
        var encrypted = await _context.BasicAuthCredentials.SingleOrDefaultAsync(c =>
            c.Integration == integration
        );

        if (encrypted is null)
        {
            return null;
        }

        return new BasicAuthCredentials
        {
            Integration = encrypted.Integration,
            OwnedBy = encrypted.OwnedBy,
            Username = Username.From(_encryption.Decrypt(encrypted.Username)),
            Password = Password.From(_encryption.Decrypt(encrypted.Password)),
        };
    }
}
