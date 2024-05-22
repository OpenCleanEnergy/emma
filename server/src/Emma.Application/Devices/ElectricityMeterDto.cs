using Emma.Domain;
using Emma.Domain.Meters;
using Emma.Domain.Units;
using Riok.Mapperly.Abstractions;

namespace Emma.Application.Devices;

[Mapper]
public partial class ElectricityMeterDto
{
    public required ElectricityMeterId Id { get; init; }
    public required DeviceName Name { get; init; }
    public required GridPowerDirection CurrentPowerDirection { get; init; }
    public required Watt CurrentPower { get; init; }

    public static partial ElectricityMeterDto From(ElectricityMeter electricityMeter);
}
