using Emma.Domain.Events;
using MediatR;

namespace Emma.Application.Shared.Events;

public interface IEventHandler<TEvent, TEventChannel>
    : IRequestHandler<EventRequest<TEvent, TEventChannel>>
    where TEvent : IEvent
    where TEventChannel : IEventChannel;
