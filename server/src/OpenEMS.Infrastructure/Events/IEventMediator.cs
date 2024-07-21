using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events;

public interface IEventMediator
{
    Task Send(IEvent domainEvent, IEventChannel eventChannel, CancellationToken cancellationToken);
}
