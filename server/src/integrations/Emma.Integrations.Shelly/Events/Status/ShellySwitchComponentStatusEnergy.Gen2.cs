using System.Text.Json.Serialization;
using Emma.Domain.Units;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Events.Status;

public class ShellySwitchComponentStatusEnergy
{
    public WattHours Total { get; init; }
}
