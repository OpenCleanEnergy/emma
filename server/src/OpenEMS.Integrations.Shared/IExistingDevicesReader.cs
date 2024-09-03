using OpenEMS.Domain;

namespace OpenEMS.Integrations.Shared;

public interface IExistingDevicesReader
{
    Task<IReadOnlyCollection<IntegrationIdentifier>> GetExistingDevicesIdentifier();
}
