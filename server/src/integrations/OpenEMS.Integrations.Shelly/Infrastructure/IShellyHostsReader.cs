using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Infrastructure;

public interface IShellyHostsReader
{
    Task WaitForChanges(CancellationToken cancellationToken);
    Task<IReadOnlySet<FullyQualifiedDomainName>> GetAllHosts();
    Task<FullyQualifiedDomainName?> FindBy(ShellyDeviceId deviceId);
}
