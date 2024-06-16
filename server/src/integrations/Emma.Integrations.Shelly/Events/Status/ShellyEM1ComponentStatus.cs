using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/EM1#status.
/// </summary>
public class ShellyEM1ComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("act_power")]
    public Watt? ActivePower { get; init; }
}
