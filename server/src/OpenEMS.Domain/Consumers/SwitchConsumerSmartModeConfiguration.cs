using NMolecules.DDD;
using OpenEMS.Domain.Units;

namespace OpenEMS.Domain.Consumers;

[ValueObject]
public record SwitchConsumerSmartModeConfiguration(
    Watt Nennleistung,
    TimeSpan MinimaleEinschaltdauer,
    TimeSpan Wiedereinschaltverzögerung
)
{
    public static SwitchConsumerSmartModeConfiguration Default =>
        new(Watt.Zero, TimeSpan.Zero, TimeSpan.Zero);
}
