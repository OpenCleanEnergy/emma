namespace Emma.Infrastructure.Events.CAP;

public class CapRabbitMQConfiguration
{
    public string ExchangeName { get; init; } = "emma.default.topic";
    public required Uri Uri { get; init; }
}
