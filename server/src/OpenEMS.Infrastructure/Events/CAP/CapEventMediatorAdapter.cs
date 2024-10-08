using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events.CAP;

public class CapEventMediatorAdapter<TEventChannel>
    where TEventChannel : IEventChannel, new()
{
    private readonly IEventMediator _eventMediator;

    public CapEventMediatorAdapter(IEventMediator eventMediator)
    {
        _eventMediator = eventMediator;
    }

    public virtual async Task Send(IEvent domainEvent, CancellationToken cancellationToken)
    {
        var eventChannel = new TEventChannel();
        await _eventMediator.Send(domainEvent, eventChannel, cancellationToken);
    }
}
