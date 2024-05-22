using Emma.Domain.Units;

namespace Emma.Application.Home;

public class ProducerStatusDto
{
    public bool IsAvailable { get; private set; } = true;
    public required Watt CurrentPowerProduction { get; init; }
    public required Watt MaximumPowerProduction { get; init; }

    public static ProducerStatusDto Unavailable() =>
        new()
        {
            IsAvailable = false,
            CurrentPowerProduction = Watt.Zero,
            MaximumPowerProduction = Watt.Zero,
        };
}
