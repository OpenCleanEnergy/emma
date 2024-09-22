using OpenEMS.Integrations.Shared;

namespace OpenEMS.Server.Integrations;

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

    public IScopedService<TService> GetScopedInstance()
    {
        var scope = _serviceScopeFactory.CreateScope();
        var service = scope.ServiceProvider.GetRequiredService<TService>();
        return new ScopedService<TService>(scope, service);
    }
}
