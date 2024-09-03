namespace OpenEMS.Infrastructure.Events.CAP;

public class CapRabbitMQConfiguration
{
    public string ExchangeName { get; init; } = "openems.default.topic";
    public required Uri Url { get; init; }
}
