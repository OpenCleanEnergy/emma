namespace OpenEMS.Application.Shared.DependencyInjection;

public interface IScopedServiceFactory<TService>
    where TService : class
{
    ScopedService<TService> GetScopedInstance();
}
