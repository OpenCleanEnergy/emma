using MediatR;
using OpenEMS.Domain.Events;

namespace OpenEMS.Application.Shared.Events;

public interface IEventHandler<TEvent, TEventChannel>
    : IRequestHandler<EventRequest<TEvent, TEventChannel>>
    where TEvent : IEvent
    where TEventChannel : IEventChannel;
