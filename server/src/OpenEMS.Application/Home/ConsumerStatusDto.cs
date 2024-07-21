using OpenEMS.Domain.Units;

namespace OpenEMS.Application.Home;

public class ConsumerStatusDto
{
    public bool IsAvailable { get; private set; } = true;
    public required Watt CurrentPowerConsumption { get; init; }
    public required Watt MaximumPowerConsumption { get; init; }

    public static ConsumerStatusDto Unavailable() =>
        new()
        {
            IsAvailable = false,
            CurrentPowerConsumption = Watt.Zero,
            MaximumPowerConsumption = Watt.Zero,
        };
}
