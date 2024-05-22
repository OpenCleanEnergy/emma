using Emma.Domain.Units;

namespace Emma.Application.Home;

public class BatteryStatusDto
{
    public bool IsAvailable { get; private set; } = true;
    public required BatteryChargeStatus ChargeStatus { get; init; }
    public required Percentage Charge { get; init; }

    public static BatteryStatusDto Unavailable() =>
        new()
        {
            IsAvailable = false,
            ChargeStatus = BatteryChargeStatus.Idle,
            Charge = Percentage.Zero
        };
}
