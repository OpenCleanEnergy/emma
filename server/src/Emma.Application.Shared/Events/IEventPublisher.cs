using Emma.Domain.Events;

namespace Emma.Application.Shared.Events;

public interface IEventPublisher
{
    Task Publish(IHasEvents entity);
    Task Publish(IEvent domainEvent);
}
