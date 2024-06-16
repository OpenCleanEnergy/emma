using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/EMData#status.
/// </summary>
public class ShellyEMDataComponentStatus
{
    public required ShellyChannelIndex Id { get; init; }

    [JsonPropertyName("total_act")]
    public WattHours TotalActive { get; init; }

    [JsonPropertyName("total_act_ret")]
    public WattHours TotalActiveReturned { get; init; }
}
