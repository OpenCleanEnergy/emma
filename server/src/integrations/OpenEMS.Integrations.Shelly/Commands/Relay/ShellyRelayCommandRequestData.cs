using System.Text.Json.Serialization;

namespace OpenEMS.Integrations.Shelly.Commands.Relay;

public class ShellyRelayCommandRequestData
{
    [JsonPropertyName("cmd")]
    public string Command { get; } = "relay";

    [JsonPropertyName("params")]
    public required ShellyRelayCommandRequestDataParameters Params { get; init; }
}
