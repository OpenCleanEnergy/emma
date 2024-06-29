using Emma.Application.Shared.Events;

namespace Emma.Application.Integrations.Events;

public class IntegrationsEventChannel : IEventChannel
{
    public string Name => "emma.integrations";
    public int PrefetchCount => 3;
}
