using OpenEMS.Domain;

namespace OpenEMS.Integrations.Shared.Credentials;

public interface ICredentialsRepository
{
    void Add(BasicAuthCredentials credentials);
    Task<BasicAuthCredentials?> FindBasicAuthCredentials(IntegrationId integration);
}
