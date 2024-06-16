using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/EM#status.
/// </summary>
public class ShellyEMComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("total_act_power")]
    public Watt? TotalActivePower { get; init; }
}
