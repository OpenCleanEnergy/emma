using OpenEMS.Domain.Events;

namespace OpenEMS.Integrations.Shelly.Events;

public sealed class UnknownShellyEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "emma.integrations.shelly.unknown";
    public required string Json { get; init; }
}
