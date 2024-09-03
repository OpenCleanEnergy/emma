using OpenEMS.Domain.Events;
using OpenEMS.Integrations.Shelly.Commands;

namespace OpenEMS.Integrations.Shelly.Events;

public sealed class ShellyCommandResponseEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "openems.integrations.shelly.response";
    public required TransactionId TrId { get; init; }

    public required ShellyCommandResponseEventData Data { get; init; }
}
