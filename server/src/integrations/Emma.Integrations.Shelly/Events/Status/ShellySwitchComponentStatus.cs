using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/Switch#status.
/// </summary>
public class ShellySwitchComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }
    public bool Output { get; init; }

    [JsonPropertyName("apower")]
    public Watt? ActivePower { get; init; }

    [JsonPropertyName("aenergy")]
    public ShellySwitchComponentStatusEnergy? ActiveEnergy { get; init; }

    [JsonPropertyName("ret_aenergy")]
    public ShellySwitchComponentStatusEnergy? ReturnedActiveEnergy { get; init; }
}
