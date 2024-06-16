using Emma.Domain;
using Emma.Domain.Consumers;
using Emma.Domain.Units;
using Riok.Mapperly.Abstractions;

namespace Emma.Application.Devices;

[Mapper]
public partial class SwitchConsumerDto
{
    public required SwitchConsumerId Id { get; init; }
    public required DeviceName Name { get; init; }
    public required ControlMode Mode { get; init; }
    public required SwitchStatus SwitchStatus { get; init; }
    public required bool HasReportedPowerConsumption { get; init; }
    public required Watt CurrentPowerConsumption { get; init; }

    public static partial SwitchConsumerDto From(SwitchConsumer switchConsumer);
}
