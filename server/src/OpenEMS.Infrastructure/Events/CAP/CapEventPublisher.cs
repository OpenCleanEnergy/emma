using DotNetCore.CAP;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events.CAP;

public class CapEventPublisher : IEventPublisher
{
    private readonly ICapPublisher _publisher;

    public CapEventPublisher(ICapPublisher publisher)
    {
        _publisher = publisher;
    }

    public async Task Publish(IHasEvents entity)
    {
        var events = entity.GetEvents();
        foreach (var domainEvent in events)
        {
            await Publish(domainEvent);
        }
    }

    public async Task Publish(IEvent domainEvent)
    {
        await _publisher.PublishAsync(domainEvent.EventKey.Value, domainEvent);
    }
}
