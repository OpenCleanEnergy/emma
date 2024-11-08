using Microsoft.EntityFrameworkCore;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Infrastructure.Integrations.Shelly;

public class GrantedShellyDeviceRepository : IGrantedShellyDeviceRepository
{
    private readonly DbSet<GrantedShellyDevice> _set;
    private readonly ICurrentUserReader _currentUserReader;

    public GrantedShellyDeviceRepository(
        AppDbContext dbContext,
        ICurrentUserReader currentUserReader
    )
    {
        _set = dbContext.GrantedShellyDevices;
        _currentUserReader = currentUserReader;
    }

    private IQueryable<GrantedShellyDevice> Query =>
        _currentUserReader.GetUserIdOrDefault().HasValue ? _set : _set.IgnoreQueryFilters();

    public void AddMany(IEnumerable<GrantedShellyDevice> grantedShellyDevices)
    {
        _set.AddRange(grantedShellyDevices);
    }

    public async Task<IReadOnlyCollection<GrantedShellyDevice>> GetAll()
    {
        return await Query.ToArrayAsync();
    }

    public async Task RemoveBy(ShellyDeviceId deviceId)
    {
        var entitiesToRemove = await Query.Where(x => x.DeviceId == deviceId).ToArrayAsync();
        _set.RemoveRange(entitiesToRemove);
    }
}
