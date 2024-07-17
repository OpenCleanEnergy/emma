using System.Diagnostics.CodeAnalysis;
using Emma.Domain.Events;

namespace Emma.Application.Shared.Events;

[SuppressMessage(
    "Major Code Smell",
    "S2326:Unused type parameters should be removed",
    Justification = "TEventChannel is actually used."
)]
public sealed record EventRequest<TEvent, TEventChannel>(TEvent DomainEvent) : IEventRequest
    where TEvent : IEvent
    where TEventChannel : IEventChannel;
