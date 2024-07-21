using System.Text.Json.Serialization;
using OpenEMS.Domain.Units;

namespace OpenEMS.Integrations.Shelly.Events.Status;

public class ShellyEMeterStatus
{
    public Watt Power { get; init; }
    public WattHours Total { get; init; }

    [JsonPropertyName("total_returned")]
    public WattHours TotalReturned { get; init; }
}
