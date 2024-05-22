using Emma.Application.Shared.Events;
using Emma.Domain.Events;

namespace Emma.Server.Events;

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
