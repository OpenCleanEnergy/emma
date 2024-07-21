namespace OpenEMS.Infrastructure.Events.CAP;

public class CapRabbitMQConfiguration
{
    public string ExchangeName { get; init; } = "emma.default.topic";
    public required Uri Url { get; init; }
}
