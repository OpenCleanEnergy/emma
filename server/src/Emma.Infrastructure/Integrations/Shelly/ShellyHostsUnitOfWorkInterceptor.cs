using Emma.Infrastructure.Persistence;
using Emma.Infrastructure.Persistence.EntityFramework;
using Emma.Integrations.Shelly.Domain;

namespace Emma.Infrastructure;

public class ShellyHostsUnitOfWorkInterceptor : IUnitOfWorkInterceptor
{
    private readonly ShellyHostsAutoResetEvent _shellyHostsAutoResetEvent;

    public ShellyHostsUnitOfWorkInterceptor(ShellyHostsAutoResetEvent shellyHostsAutoResetEvent)
    {
        _shellyHostsAutoResetEvent = shellyHostsAutoResetEvent;
    }

    public Task UnitOfWorkCompleted(AppDbContext dbContext)
    {
        var potentiallyChangesDetected = dbContext
            .ChangeTracker.Entries<GrantedShellyDevice>()
            .Any();

        if (potentiallyChangesDetected)
        {
            _shellyHostsAutoResetEvent.Set();
        }

        return Task.CompletedTask;
    }
}
