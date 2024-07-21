using System.Text.Json.Serialization;
using OpenEMS.Domain.Units;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/EM#status.
/// </summary>
public class ShellyEMComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("total_act_power")]
    public Watt? TotalActivePower { get; init; }
}
