using Emma.Domain.Events;

namespace Emma.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/integrator-api/communication#shellystatusonchange.
/// </summary>
public class ShellyStatusOnChangeEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "emma.integrations.shelly.status-on-change";
    public required ShellyStatus Status { get; init; }
}
