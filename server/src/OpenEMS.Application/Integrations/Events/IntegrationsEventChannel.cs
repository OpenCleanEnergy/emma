using OpenEMS.Application.Shared.Events;

namespace OpenEMS.Application.Integrations.Events;

public class IntegrationsEventChannel : IEventChannel
{
    public string Name => "openems.integrations";
    public int PrefetchCount => 3;
}
