using System.Threading.Channels;
using Emma.Application.Shared.Events;
using Emma.Application.Shared.Logging;
using Emma.Domain.Events;

namespace Emma.Infrastructure.Events.InMemory;

public sealed class InMemoryEventChannels : IInMemoryEventChannels, IDisposable
{
    private readonly CancellationTokenSource _cancellationTokenSource = new();
    private readonly ILogger _logger;
    private readonly IEventMediator _domainEventMediator;
    private readonly Dictionary<Type, Channel<IEvent>> _channelsByEventChannelType = [];
    private readonly Dictionary<Type, HashSet<EventKey>> _eventKeysByEventChannelType = [];

    public InMemoryEventChannels(
        ILogger logger,
        IEventMediator domainEventMediator,
        IEnumerable<EventHandlerDescriptor> eventHandlerDescriptors
    )
    {
        _logger = logger;
        _domainEventMediator = domainEventMediator;

        foreach (var descriptor in eventHandlerDescriptors)
        {
            Subscribe(descriptor);
        }
    }

    public async ValueTask Write(IEvent domainEvent)
    {
        var keys = _eventKeysByEventChannelType
            .Where(kvp => kvp.Value.Contains(domainEvent.EventKey))
            .Select(kvp => kvp.Key);

        foreach (var key in keys)
        {
            await _channelsByEventChannelType[key].Writer.WriteAsync(domainEvent);
        }
    }

    public void Dispose()
    {
        _cancellationTokenSource.Dispose();
    }

    private void Subscribe(EventHandlerDescriptor eventHandlerDescriptor)
    {
        var key = eventHandlerDescriptor.EventChannel.GetType();

        if (!_channelsByEventChannelType.ContainsKey(key))
        {
            var channel = Channel.CreateUnbounded<IEvent>();
            _channelsByEventChannelType.Add(key, channel);
            for (int i = 0; i < eventHandlerDescriptor.EventChannel.PrefetchCount; i++)
            {
                _ = ProcessEvents(eventHandlerDescriptor.EventChannel, i, channel.Reader);
            }
        }

        if (!_eventKeysByEventChannelType.TryGetValue(key, out var eventKeys))
        {
            eventKeys = _eventKeysByEventChannelType[key] = [];
        }

        eventKeys.Add(eventHandlerDescriptor.DomainEvent.EventKey);
    }

    private async Task ProcessEvents(
        IEventChannel eventChannel,
        int index,
        ChannelReader<IEvent> reader
    )
    {
        using var context = _logger.BeginContext(
            KeyValuePair.Create<string, object?>("EventChannel", eventChannel.Name),
            KeyValuePair.Create<string, object?>("EventChannelIndex", index)
        );

        var token = _cancellationTokenSource.Token;

        try
        {
            await foreach (var domainEvent in reader.ReadAllAsync(token))
            {
                token.ThrowIfCancellationRequested();
                await HandleSingleEvent(eventChannel, domainEvent, token);
            }
        }
        catch (OperationCanceledException exception) when (exception.CancellationToken == token)
        {
            _logger.Info("Channel disposed.");
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Error processing events.");
        }
    }

    private async Task HandleSingleEvent(
        IEventChannel eventChannel,
        IEvent domainEvent,
        CancellationToken token
    )
    {
        using var context = _logger.BeginContext(
            KeyValuePair.Create<string, object?>("DomainEvent", domainEvent.EventKey)
        );

        try
        {
            await _domainEventMediator.Send(domainEvent, eventChannel, token);
        }
        catch (OperationCanceledException exception) when (exception.CancellationToken == token)
        {
            _logger.Info("Domain event was cancelled by channel disposal.");
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Error processing domain event {@DomainEvent}", domainEvent);
        }
    }
}
