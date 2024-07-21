using OpenEMS.Domain.Events;

namespace OpenEMS.Domain.Consumers.Events;

public record SwitchConsumerSwitchedEvent(
    SwitchConsumerId Id,
    IntegrationIdentifier Integration,
    SwitchStatus Status,
    SwitchActor Actor
) : IEvent
{
    public EventKey EventKey { get; } = EventKey.From("consumers.switch.switched");
    public DateTimeOffset Timestamp { get; init; } = AmbientTimeProvider.UtcNow;
}
