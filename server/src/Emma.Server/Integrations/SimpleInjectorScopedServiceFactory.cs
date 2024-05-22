using Emma.Integrations.Shared;
using SimpleInjector;
using SimpleInjector.Lifestyles;

namespace Emma.Server;

public class SimpleInjectorScopedServiceFactory<TService> : IScopedServiceFactory<TService>
    where TService : class
{
    private readonly Container _container;
    private readonly Func<TService> _serviceFactory;

    public SimpleInjectorScopedServiceFactory(Container container, Func<TService> serviceFactory)
    {
        _container = container;
        _serviceFactory = serviceFactory;
    }

    public IScopedService<TService> GetScopedInstance()
    {
        var scope = AsyncScopedLifestyle.BeginScope(_container);
        var service = _serviceFactory();
        return new SimpleInjectorScopedService<TService>(scope, service);
    }
}
