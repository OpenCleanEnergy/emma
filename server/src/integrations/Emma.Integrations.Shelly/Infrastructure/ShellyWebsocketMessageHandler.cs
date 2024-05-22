using Emma.Application.Shared.Events;
using Emma.Application.Shared.Logging;
using Emma.Integrations.Shelly.Events;
using Websocket.Client;

namespace Emma.Integrations.Shelly.Infrastructure;

public class ShellyWebsocketMessageHandler
{
    private readonly ShellyEventSerializer _serializer;
    private readonly IEventPublisher _eventPublisher;
    private readonly ILogger _logger;

    public ShellyWebsocketMessageHandler(
        ShellyEventSerializer serializer,
        IEventPublisher eventPublisher,
        ILogger logger
    )
    {
        _serializer = serializer;
        _eventPublisher = eventPublisher;
        _logger = logger;
    }

    public virtual async Task Handle(ResponseMessage message)
    {
        try
        {
            if (message.Text is null)
            {
                _logger.Debug("Message text is null");
                return;
            }

            var shellyEvent = _serializer.Deserialize(message.Text);

            if (shellyEvent is null)
            {
                _logger.Debug("Message deserialized to null: {Message}", message.Text);
                return;
            }

            _logger.Debug("Message deserialized to {@ShellyEvent}", shellyEvent);
            await _eventPublisher.Publish(shellyEvent);
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Error processing {Message}", message);
        }
    }
}
