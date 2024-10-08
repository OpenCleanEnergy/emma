using OpenEMS.Domain.Units;

namespace OpenEMS.Application.Home;

public class HomeStatusDto
{
    public BatteryStatusDto BatteryStatus { get; init; } =
        new BatteryStatusDto
        {
            ChargeStatus = BatteryChargeStatus.Charging,
            Charge = Percentage.From(63),
        };
    public required GridStatusDto GridStatus { get; init; }
    public required ConsumerStatusDto ConsumerStatus { get; init; }
    public required ProducerStatusDto ProducerStatus { get; init; }
}
