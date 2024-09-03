using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events.InMemory;

public interface IInMemoryEventChannels
{
    ValueTask Write(IEvent domainEvent);
}
