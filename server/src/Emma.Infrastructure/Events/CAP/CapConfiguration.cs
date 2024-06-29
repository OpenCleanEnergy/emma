namespace Emma.Infrastructure.Events.CAP;

public class CapConfiguration
{
    public required CapRabbitMQConfiguration RabbitMQ { get; init; }
}
