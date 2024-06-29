namespace Emma.Infrastructure.Events.CAP;

public class CapLavinMQConfiguration
{
    public string ExchangeName { get; init; } = "emma.default.topic";
    public required Uri Url { get; init; }
}
