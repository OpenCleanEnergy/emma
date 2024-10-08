using OpenEMS.Application.Shared.Events;
using OpenEMS.Application.Shared.Logging;

namespace OpenEMS.Integrations.Shelly.Events.Handler;

public class ShellyCommandResponseEventHandler
    : IEventHandler<ShellyCommandResponseEvent, ShellyEventChannel>
{
    private readonly ILogger _logger;

    public ShellyCommandResponseEventHandler(ILogger<ShellyCommandResponseEventHandler> logger)
    {
        _logger = logger;
    }

    public Task Handle(
        EventRequest<ShellyCommandResponseEvent, ShellyEventChannel> request,
        CancellationToken cancellationToken
    )
    {
        var domainEvent = request.DomainEvent;
        if (!domainEvent.Data.IsOk)
        {
            _logger.Warning(
                "Shelly command for device {DeviceId} failed: {Response}",
                domainEvent.DeviceId,
                domainEvent.Data.Res
            );
        }

        return Task.CompletedTask;
    }
}
