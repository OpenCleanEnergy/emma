using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Infrastructure;

public interface IShellyWebsocketManager
{
    Task Refresh(IReadOnlySet<FullyQualifiedDomainName> hosts, CancellationToken cancellationToken);
    void Send(FullyQualifiedDomainName host, string json);
}
