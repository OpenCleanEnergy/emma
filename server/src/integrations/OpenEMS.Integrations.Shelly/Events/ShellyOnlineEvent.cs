using OpenEMS.Domain.Events;

namespace OpenEMS.Integrations.Shelly.Events;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/integrator-api/communication#shellyonline
/// </summary>
public sealed class ShellyOnlineEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "emma.integrations.shelly.online";
    public required ShellyOnlineStatus Online { get; init; }
}
