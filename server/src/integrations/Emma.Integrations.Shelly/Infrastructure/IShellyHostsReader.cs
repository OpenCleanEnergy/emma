using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Infrastructure;

public interface IShellyHostsReader
{
    Task WaitForChanges(CancellationToken cancellationToken);
    Task<IReadOnlySet<FullyQualifiedDomainName>> GetAllHosts();
    Task<FullyQualifiedDomainName?> FindBy(ShellyDeviceId deviceId);
}
