using System.Text.Json.Serialization;
using Emma.Domain.Units;

namespace Emma.Integrations.Shelly.Events;

public class ShellyEMeterStatus
{
    public Watt Power { get; init; }
    public WattHours Total { get; init; }

    [JsonPropertyName("total_returned")]
    public WattHours TotalReturned { get; init; }
}
