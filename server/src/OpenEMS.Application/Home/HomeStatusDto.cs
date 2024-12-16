using OpenEMS.Domain.Units;

namespace OpenEMS.Application.Home;

public class HomeStatusDto
{
    public BatteryStatusDto BatteryStatus { get; init; } = BatteryStatusDto.Unavailable();
    public required GridStatusDto GridStatus { get; init; }
    public required ConsumerStatusDto ConsumerStatus { get; init; }
    public required ProducerStatusDto ProducerStatus { get; init; }
}
