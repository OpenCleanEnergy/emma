using Emma.Domain.Events;
using Emma.Integrations.Shelly.Commands;

namespace Emma.Integrations.Shelly.Events;

public sealed class ShellyCommandResponseEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "emma.integrations.shelly.response";
    public required TransactionId TrId { get; init; }

    public required ShellyCommandResponseEventData Data { get; init; }
}
