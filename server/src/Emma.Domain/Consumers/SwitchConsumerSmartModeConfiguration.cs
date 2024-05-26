using Emma.Domain.Units;
using NMolecules.DDD;

namespace Emma.Domain.Consumers;

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
