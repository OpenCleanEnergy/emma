using OpenEMS.Application.Shared.Events;
using OpenEMS.Application.Shared.Logging;
using OpenEMS.Integrations.Shelly.Events;
using Websocket.Client;

namespace OpenEMS.Integrations.Shelly.Infrastructure;

public class ShellyWebsocketMessageHandler
{
    private readonly ShellyEventSerializer _serializer;
    private readonly IEventPublisher _eventPublisher;
    private readonly ILogger _logger;

    public ShellyWebsocketMessageHandler(
        ShellyEventSerializer serializer,
        IEventPublisher eventPublisher,
        ILogger<ShellyWebsocketMessageHandler> logger
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

            _logger.Debug(
                "Message {Message} deserialized to {@ShellyEvent}",
                message.Text,
                shellyEvent
            );
            await _eventPublisher.Publish(shellyEvent);
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Error processing {Message}", message);
        }
    }
}
