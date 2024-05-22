using Emma.Application.Shared.Events;
using Emma.Domain.Events;

namespace Emma.Infrastructure.Events;

public record EventHandlerDescriptor(IEvent DomainEvent, IEventChannel EventChannel);
