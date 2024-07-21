using System.Text.Json.Serialization;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Commands.Relay;

public class ShellyRelayCommandRequest : ShellyCommandRequest
{
    [JsonPropertyName("data")]
    public required ShellyRelayCommandRequestData Data { get; init; }

    public static ShellyRelayCommandRequest On(
        ShellyDeviceId deviceId,
        ShellyChannelIndex channelIndex
    ) => Turn(deviceId, channelIndex, "on");

    public static ShellyRelayCommandRequest Off(
        ShellyDeviceId deviceId,
        ShellyChannelIndex channelIndex
    ) => Turn(deviceId, channelIndex, "off");

    private static ShellyRelayCommandRequest Turn(
        ShellyDeviceId deviceId,
        ShellyChannelIndex channelIndex,
        string turn
    )
    {
        return new ShellyRelayCommandRequest
        {
            DeviceId = deviceId,
            Data = new ShellyRelayCommandRequestData
            {
                Params = new ShellyRelayCommandRequestDataParameters(channelIndex, turn)
            }
        };
    }
}
