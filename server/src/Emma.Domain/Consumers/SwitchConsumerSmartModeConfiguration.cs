using Emma.Domain.Units;

namespace Emma.Domain.Consumers;

public record SwitchConsumerSmartModeConfiguration(
    Watt Nennleistung,
    TimeSpan MinimaleEinschaltdauer,
    TimeSpan Wiedereinschaltverzögerung
)
{
    public static SwitchConsumerSmartModeConfiguration Default =>
        new(Watt.Zero, TimeSpan.Zero, TimeSpan.Zero);
}
