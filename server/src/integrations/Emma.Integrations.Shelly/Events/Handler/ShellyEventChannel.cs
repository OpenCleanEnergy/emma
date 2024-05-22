using Emma.Application.Shared.Events;

namespace Emma.Integrations.Shelly.Events.Handler;

public class ShellyEventChannel : IEventChannel
{
    public string Name => "emma.integrations.shelly";
    public int PrefetchCount => 3;
}
