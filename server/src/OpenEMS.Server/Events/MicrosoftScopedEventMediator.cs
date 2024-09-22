using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;
using OpenEMS.Infrastructure.Events;

namespace OpenEMS.Server.Events;

public class MicrosoftScopedEventMediator<TEventMediator> : IEventMediator
    where TEventMediator : class, IEventMediator
{
    private readonly IServiceScopeFactory _serviceScopeFactory;

    public MicrosoftScopedEventMediator(IServiceScopeFactory serviceScopeFactory)
    {
        _serviceScopeFactory = serviceScopeFactory;

        // Test
        using var scope = _serviceScopeFactory.CreateScope();
        _ = scope.ServiceProvider.GetRequiredService<TEventMediator>();
    }

    public async Task Send(
        IEvent domainEvent,
        IEventChannel eventChannel,
        CancellationToken cancellationToken
    )
    {
        using var scope = _serviceScopeFactory.CreateScope();
        var mediator = scope.ServiceProvider.GetRequiredService<TEventMediator>();
        await mediator.Send(domainEvent, eventChannel, cancellationToken);
    }
}
