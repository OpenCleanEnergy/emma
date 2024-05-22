using Emma.Application.Shared.Events;
using Emma.Domain.Events;
using MediatR;

namespace Emma.Infrastructure;

public class MediatREventMediator : IEventMediator
{
    private readonly ISender _sender;

    public MediatREventMediator(ISender sender)
    {
        _sender = sender;
    }

    public async Task Send(
        IEvent domainEvent,
        IEventChannel eventChannel,
        CancellationToken cancellationToken
    )
    {
        var requestType = typeof(EventRequest<,>).MakeGenericType(
            domainEvent.GetType(),
            eventChannel.GetType()
        );

        var request = Activator.CreateInstance(requestType, domainEvent)!;
        await _sender.Send(request, cancellationToken);
    }
}
