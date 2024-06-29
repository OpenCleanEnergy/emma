using Emma.Domain.Events;

namespace Emma.Infrastructure.Events.InMemory;

public interface IInMemoryEventChannels
{
    ValueTask Write(IEvent domainEvent);
}
