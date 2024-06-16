using Emma.Domain.Units;

namespace Emma.Integrations.Shelly.Events.Status;

public class ShellySwitchComponentStatusEnergy
{
    public WattHours Total { get; init; }
}
