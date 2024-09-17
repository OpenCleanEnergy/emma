namespace OpenEMS.Application.Shared.DependencyInjection;

public sealed class ScopedService<TService>(IDisposable scope, TService service) : IDisposable
{
    private readonly IDisposable _scope = scope;

    public TService Service { get; } = service;

    public void Dispose()
    {
        _scope.Dispose();
    }
}
