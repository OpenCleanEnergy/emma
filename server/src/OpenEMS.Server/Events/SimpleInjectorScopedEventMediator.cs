using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;
using OpenEMS.Infrastructure.Events;
using SimpleInjector;
using SimpleInjector.Lifestyles;

namespace OpenEMS.Server.Events;

public class SimpleInjectorScopedEventMediator : IEventMediator
{
    private readonly Container _container;
    private readonly IEventMediator _domainEventMediator;

    public SimpleInjectorScopedEventMediator(
        Container container,
        IEventMediator domainEventMediator
    )
    {
        _container = container;
        _domainEventMediator = domainEventMediator;
    }

    public async Task Send(
        IEvent domainEvent,
        IEventChannel eventChannel,
        CancellationToken cancellationToken
    )
    {
        using var scope = AsyncScopedLifestyle.BeginScope(_container);
        await _domainEventMediator.Send(domainEvent, eventChannel, cancellationToken);
    }
}
