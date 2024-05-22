using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection.Extensions;

namespace Emma.Server.LongPolling;

public static class LongPollingServiceCollectionExtensions
{
    public static IServiceCollection AddLongPolling(this IServiceCollection services)
    {
        services.TryAddSingleton(TimeProvider.System);

        services.AddSingleton<DevicesLongPolling>();
        services.AddScoped<
            IInterceptor,
            EntityFrameworkLongPollingInterceptor<DevicesLongPolling>
        >();

        return services;
    }
}
