using Emma.Domain.Events;

namespace Emma.Infrastructure.Events;

public interface IInMemoryEventChannels
{
    ValueTask Write(IEvent domainEvent);
}
