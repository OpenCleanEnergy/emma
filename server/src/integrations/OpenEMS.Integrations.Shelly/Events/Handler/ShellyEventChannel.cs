using OpenEMS.Application.Shared.Events;

namespace OpenEMS.Integrations.Shelly.Events.Handler;

public class ShellyEventChannel : IEventChannel
{
    public string Name => "openems.integrations.shelly";
    public int PrefetchCount => 3;
}
