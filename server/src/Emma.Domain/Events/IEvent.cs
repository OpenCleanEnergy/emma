namespace Emma.Domain.Events;

public interface IEvent
{
    EventKey EventKey { get; }
    DateTimeOffset Timestamp { get; init; }
}
