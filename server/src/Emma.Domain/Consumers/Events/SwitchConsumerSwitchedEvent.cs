using Emma.Domain.Events;

namespace Emma.Domain.Consumers.Events;

public record SwitchConsumerSwitchedEvent(
    SwitchConsumerId Id,
    IntegrationIdentifier Integration,
    SwitchStatus Status,
    SwitchActor Actor
) : IEvent
{
    public EventKey EventKey { get; } = EventKey.From("consumers.switch.switched-on");
    public DateTimeOffset Timestamp { get; init; } = AmbientTimeProvider.UtcNow;
}
