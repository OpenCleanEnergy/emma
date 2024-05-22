using Emma.Application.Shared.Events;
using Emma.Domain.Events;
using Emma.Infrastructure;
using SimpleInjector;
using SimpleInjector.Lifestyles;

namespace Emma.Server.Events;

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
