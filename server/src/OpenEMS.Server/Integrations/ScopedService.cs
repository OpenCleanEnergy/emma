using OpenEMS.Integrations.Shared;

namespace OpenEMS.Server.Integrations;

public sealed class ScopedService<TService>(IDisposable scope, TService service)
    : IScopedService<TService>
    where TService : class
{
    private readonly IDisposable _scope = scope;

    public TService Service { get; } = service;

    public void Dispose()
    {
        _scope.Dispose();
    }
}
