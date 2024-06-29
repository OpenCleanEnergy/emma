namespace Emma.Infrastructure.Events.CAP;

public class CapRabbitMQConfiguration
{
    public required string Host { get; init; }
    public required int Port { get; init; }
    public required string Username { get; init; }
    public required string Password { get; init; }
    public string ExchangeName { get; init; } = "emma.default.topic";
}
