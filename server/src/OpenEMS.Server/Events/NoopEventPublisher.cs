using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Server.Events;

public class NoopEventPublisher : IEventPublisher
{
    public Task Publish(IHasEvents entity)
    {
        return Task.CompletedTask;
    }

    public Task Publish(IEvent domainEvent)
    {
        return Task.CompletedTask;
    }
}
