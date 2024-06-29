using Emma.Application.Shared.Events;
using Emma.Domain.Events;

namespace Emma.Infrastructure.Events;

public interface IEventMediator
{
    Task Send(IEvent domainEvent, IEventChannel eventChannel, CancellationToken cancellationToken);
}
