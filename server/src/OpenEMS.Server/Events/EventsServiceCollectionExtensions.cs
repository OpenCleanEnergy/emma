using OpenEMS.Infrastructure.Events;
using OpenEMS.Infrastructure.Events.CAP;
using SimpleInjector;

namespace OpenEMS.Server.Events;

public static class EventsServiceCollectionExtensions
{
    public static void AddEvents(
        this IServiceCollection services,
        Container container,
        CapConfiguration configuration
    )
    {
        services.AddEvents(configuration);

        // Cross wiring
        services.AddSingleton(_ => container.GetInstance<IEnumerable<EventHandlerDescriptor>>());
        services.AddSingleton(_ => container.GetInstance<IEventMediator>());
    }
}
