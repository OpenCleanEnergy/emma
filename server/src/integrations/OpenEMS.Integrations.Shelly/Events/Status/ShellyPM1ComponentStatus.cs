using System.Text.Json.Serialization;
using OpenEMS.Domain.Units;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/PM1#status.
/// </summary>
public class ShellyPM1ComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("apower")]
    public Watt ActivePower { get; init; }

    [JsonPropertyName("aenergy")]
    public required ShellyPM1ComponentStatusEnergy ActiveEnergy { get; init; }

    [JsonPropertyName("ret_aenergy")]
    public required ShellyPM1ComponentStatusEnergy ReturnedActiveEnergy { get; init; }
}
