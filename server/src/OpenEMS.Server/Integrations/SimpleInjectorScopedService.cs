using OpenEMS.Integrations.Shared;

namespace OpenEMS.Server;

public sealed class SimpleInjectorScopedService<TService> : IScopedService<TService>
    where TService : class
{
    private readonly IDisposable _scope;

    public SimpleInjectorScopedService(IDisposable scope, TService service)
    {
        _scope = scope;
        Service = service;
    }

    public TService Service { get; }

    public void Dispose()
    {
        _scope.Dispose();
    }
}
