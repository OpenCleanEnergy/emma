using OpenEMS.Integrations.Shelly.Domain.ValueObjects;
using OpenEMS.Integrations.Shelly.Infrastructure;

namespace OpenEMS.Integrations.Shelly.Commands;

public class ShellyCommandSender
{
    private readonly IShellyWebsocketManager _websocketManager;
    private readonly ShellyCommandRequestSerializer _serializer;
    private readonly IShellyHostsReader _hostsReader;

    public ShellyCommandSender(
        IShellyHostsReader hostsReader,
        ShellyCommandRequestSerializer serializer,
        IShellyWebsocketManager websocketManager
    )
    {
        _websocketManager = websocketManager;
        _serializer = serializer;
        _hostsReader = hostsReader;
    }

    public virtual async Task Send(
        ShellyDeviceId shellyDeviceId,
        ShellyCommandRequest commandRequest
    )
    {
        var hostOrDefault = await _hostsReader.FindBy(shellyDeviceId);
        if (hostOrDefault is null)
        {
            return;
        }

        var json = _serializer.Serialize(commandRequest);
        _websocketManager.Send(hostOrDefault.Value, json);
    }
}
