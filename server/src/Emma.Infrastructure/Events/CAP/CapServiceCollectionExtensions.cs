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
                rabbitMQ.ExchangeName = configuration.LavinMQ.ExchangeName;
                rabbitMQ.ConnectionFactoryOptions = (factory) =>
                {
                    factory.Uri = configuration.LavinMQ.Url;
                };
            });
        });
    }
}
