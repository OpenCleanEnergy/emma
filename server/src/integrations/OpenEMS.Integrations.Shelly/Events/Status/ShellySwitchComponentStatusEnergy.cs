using OpenEMS.Domain.Units;

namespace OpenEMS.Integrations.Shelly.Events.Status;

public class ShellySwitchComponentStatusEnergy
{
    public WattHours Total { get; init; }
}
