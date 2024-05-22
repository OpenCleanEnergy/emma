namespace Emma.Integrations.Shared;

public interface IScopedServiceFactory<out TService>
    where TService : class
{
    IScopedService<TService> GetScopedInstance();
}
