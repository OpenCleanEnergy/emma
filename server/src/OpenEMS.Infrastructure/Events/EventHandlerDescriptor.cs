using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Events;

public record EventHandlerDescriptor(IEvent DomainEvent, IEventChannel EventChannel);
