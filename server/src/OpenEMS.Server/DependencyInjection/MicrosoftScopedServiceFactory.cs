using OpenEMS.Application.Shared.DependencyInjection;

namespace OpenEMS.Server.DependencyInjection;

public class MicrosoftScopedServiceFactory<TService> : IScopedServiceFactory<TService>
    where TService : class
{
    private readonly IServiceScopeFactory _serviceScopeFactory;

    public MicrosoftScopedServiceFactory(IServiceScopeFactory serviceScopeFactory)
    {
        _serviceScopeFactory = serviceScopeFactory;

        // Test
        using var scope = _serviceScopeFactory.CreateScope();
        _ = scope.ServiceProvider.GetRequiredService<TService>();
    }

    public ScopedService<TService> GetScopedInstance()
    {
        var scope = _serviceScopeFactory.CreateScope();
        var service = scope.ServiceProvider.GetRequiredService<TService>();
        return new ScopedService<TService>(scope, service);
    }
}
