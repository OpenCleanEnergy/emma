using System.Text.Json.Serialization;
using OpenEMS.Domain.Units;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/EM1Data#status.
/// </summary>
public class ShellyEM1DataComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("total_act_energy")]
    public WattHours TotalActiveEnergy { get; init; }

    [JsonPropertyName("total_act_ret_energy")]
    public WattHours TotalActiveReturnedEnergy { get; init; }
}
