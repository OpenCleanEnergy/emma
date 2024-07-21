using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events.InMemory;

public class InMemoryEventPublisher : IEventPublisher
{
    private readonly IInMemoryEventChannels _eventChannels;

    public InMemoryEventPublisher(IInMemoryEventChannels eventChannels)
    {
        _eventChannels = eventChannels;
    }

    public async Task Publish(IHasEvents entity)
    {
        if (!entity.HasEvents())
        {
            return;
        }

        foreach (var domainEvent in entity.GetEvents())
        {
            await _eventChannels.Write(domainEvent);
        }
    }

    public async Task Publish(IEvent domainEvent)
    {
        await _eventChannels.Write(domainEvent);
    }
}
