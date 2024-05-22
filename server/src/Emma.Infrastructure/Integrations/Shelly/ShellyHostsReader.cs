using Emma.Infrastructure.Persistence;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Emma.Integrations.Shelly.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure;

public class ShellyHostsReader : IShellyHostsReader
{
    private readonly AppDbContext _context;
    private readonly ShellyHostsAutoResetEvent _shellyHostsAutoResetEvent;

    public ShellyHostsReader(
        AppDbContext context,
        ShellyHostsAutoResetEvent shellyHostsAutoResetEvent
    )
    {
        _context = context;
        _shellyHostsAutoResetEvent = shellyHostsAutoResetEvent;
    }

    public async Task<FullyQualifiedDomainName?> FindBy(ShellyDeviceId deviceId)
    {
        var result = await _context
            .GrantedShellyDevices.AsNoTracking()
            .IgnoreQueryFilters()
            .Where(x => x.DeviceId == deviceId)
            .Select(x => new { x.Host })
            .FirstOrDefaultAsync();

        return result?.Host;
    }

    public async Task<IReadOnlySet<FullyQualifiedDomainName>> GetAllHosts()
    {
        var hosts = await _context
            .GrantedShellyDevices.AsNoTracking()
            .IgnoreQueryFilters()
            .Select(device => device.Host)
            .ToArrayAsync();

        return new HashSet<FullyQualifiedDomainName>(hosts);
    }

    public Task WaitForChanges(CancellationToken cancellationToken) =>
        _shellyHostsAutoResetEvent.WaitAsync(cancellationToken);
}
