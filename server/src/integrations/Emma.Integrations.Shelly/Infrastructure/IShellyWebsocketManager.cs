using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Infrastructure;

public interface IShellyWebsocketManager
{
    Task Refresh(IReadOnlySet<FullyQualifiedDomainName> hosts);
    void Send(FullyQualifiedDomainName host, string json);
}
