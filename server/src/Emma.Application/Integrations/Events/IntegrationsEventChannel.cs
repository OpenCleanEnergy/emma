using Emma.Application.Shared.Events;

namespace Emma.Application;

public class IntegrationsEventChannel : IEventChannel
{
    public string Name => "emma.integrations";
    public int PrefetchCount => 3;
}
