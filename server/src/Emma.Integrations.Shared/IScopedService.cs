namespace Emma.Integrations.Shared;

public interface IScopedService<out TService> : IDisposable
    where TService : class
{
    TService Service { get; }
}
