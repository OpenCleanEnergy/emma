using DotNetCore.CAP.Internal;
using DotNetCore.CAP.Serialization;
using Emma.Infrastructure.Persistence;
using Microsoft.Extensions.DependencyInjection;

namespace Emma.Infrastructure.Events.CAP;

public static class CapServiceCollectionExtensions
{
    public static void AddEvents(this IServiceCollection services, CapConfiguration configuration)
    {
        services.AddSingleton(typeof(CapEventMediatorAdapter<>));
        services.AddSingleton<IConsumerServiceSelector, CustomConsumerServiceSelector>();

        services.AddSingleton<ISerializer, CustomSerializer>();

        services.AddCap(options =>
        {
            options.UseEntityFramework<AppDbContext>();
            options.UseRabbitMQ(rabbitMQ =>
            {
                rabbitMQ.HostName = configuration.RabbitMQ.Host;
                rabbitMQ.Port = configuration.RabbitMQ.Port;
                rabbitMQ.UserName = configuration.RabbitMQ.Username;
                rabbitMQ.Password = configuration.RabbitMQ.Password;
                rabbitMQ.ExchangeName = configuration.RabbitMQ.ExchangeName;
            });
        });
    }
}
