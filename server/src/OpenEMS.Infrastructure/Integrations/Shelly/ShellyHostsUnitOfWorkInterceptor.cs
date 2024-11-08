using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Infrastructure.Persistence.EntityFramework;
using OpenEMS.Integrations.Shelly.Domain;

namespace OpenEMS.Infrastructure.Integrations.Shelly;

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
