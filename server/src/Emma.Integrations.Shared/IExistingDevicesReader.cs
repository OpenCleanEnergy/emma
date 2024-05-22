using Emma.Domain;

namespace Emma.Integrations.Shared;

public interface IExistingDevicesReader
{
    Task<IReadOnlyCollection<IntegrationIdentifier>> GetExistingDevicesIdentifier();
}
