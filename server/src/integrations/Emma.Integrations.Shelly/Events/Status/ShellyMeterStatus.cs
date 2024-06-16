using Emma.Domain.Units;

namespace Emma.Integrations.Shelly.Events.Status;

public class ShellyMeterStatus
{
    public Watt Power { get; init; }
    public WattMinutes Total { get; init; }
}
