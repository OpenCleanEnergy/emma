using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

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
