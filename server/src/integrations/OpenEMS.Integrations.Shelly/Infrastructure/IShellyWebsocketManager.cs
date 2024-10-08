using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Infrastructure;

public interface IShellyWebsocketManager
{
    Task Refresh(IReadOnlySet<FullyQualifiedDomainName> hosts, CancellationToken cancellationToken);
    void Send(FullyQualifiedDomainName host, string json);
}
