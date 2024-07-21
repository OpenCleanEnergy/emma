using OpenEMS.Domain;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Application.Devices;

[Mapper]
public partial class ProducerDto
{
    public required ProducerId Id { get; init; }
    public required DeviceName Name { get; init; }
    public required Watt CurrentPowerProduction { get; init; }

    public static partial ProducerDto From(Producer producer);
}
