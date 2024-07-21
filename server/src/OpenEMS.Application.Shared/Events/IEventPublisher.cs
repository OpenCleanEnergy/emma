using OpenEMS.Domain.Events;

namespace OpenEMS.Application.Shared.Events;

public interface IEventPublisher
{
    Task Publish(IHasEvents entity);
    Task Publish(IEvent domainEvent);
}
