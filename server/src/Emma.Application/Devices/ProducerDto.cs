using Emma.Domain;
using Emma.Domain.Producers;
using Emma.Domain.Units;
using Riok.Mapperly.Abstractions;

namespace Emma.Application.Devices;

[Mapper]
public partial class ProducerDto
{
    public required ProducerId Id { get; init; }
    public required DeviceName Name { get; init; }
    public required Watt CurrentPowerProduction { get; init; }

    public static partial ProducerDto From(Producer producer);
}
