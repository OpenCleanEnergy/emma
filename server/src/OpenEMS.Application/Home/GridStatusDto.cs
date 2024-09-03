using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Units;

namespace OpenEMS.Application.Home;

public class GridStatusDto
{
    public bool IsAvailable { get; private set; } = true;
    public required GridPowerDirection CurrentPowerDirection { get; init; }
    public required Watt CurrentPower { get; init; }
    public required Watt MaximumPowerConsumption { get; init; }
    public required Watt MaximumPowerFeedIn { get; init; }

    public static GridStatusDto Unavailable() =>
        new()
        {
            IsAvailable = false,
            CurrentPowerDirection = GridPowerDirection.None,
            CurrentPower = Watt.Zero,
            MaximumPowerConsumption = Watt.Zero,
            MaximumPowerFeedIn = Watt.Zero,
        };
}
