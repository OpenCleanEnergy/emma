using OpenEMS.Domain.Units;

namespace OpenEMS.Integrations.Shelly.Events.Status;

public class ShellyMeterStatus
{
    public Watt Power { get; init; }
    public WattMinutes Total { get; init; }
}
