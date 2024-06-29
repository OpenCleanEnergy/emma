using System.Diagnostics.CodeAnalysis;
using Emma.Domain.Events;
using MediatR;

namespace Emma.Application.Shared.Events;

[SuppressMessage(
    "Major Code Smell",
    "S2326:Unused type parameters should be removed",
    Justification = "TEventChannel is actually used."
)]
[RequiresTransaction]
public sealed record EventRequest<TEvent, TEventChannel>(TEvent DomainEvent) : IRequest
    where TEvent : IEvent
    where TEventChannel : IEventChannel;
