using Emma.Domain;
using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Producers;
using Emma.Infrastructure.Persistence;
using Emma.Integrations.Shared;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure.Integrations;

public class DevicesRepository : IDevicesRepository
{
    private readonly AppDbContext _context;

    public DevicesRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<SwitchConsumer?> FindSwitchConsumer(IntegrationIdentifier integration)
    {
        var local = _context.SwitchConsumers.Local.SingleOrDefault(x =>
            x.Integration == integration
        );

        return local
            ?? await _context
                .SwitchConsumers.IgnoreQueryFilters()
                .SingleOrDefaultAsync(x =>
                    x.Integration.Integration == integration.Integration
                    && x.Integration.Device == integration.Device
                );
    }

    public async Task<Producer?> FindProducer(IntegrationIdentifier integration)
    {
        var local = _context.Producers.Local.SingleOrDefault(x => x.Integration == integration);

        return local
            ?? await _context
                .Producers.IgnoreQueryFilters()
                .SingleOrDefaultAsync(x =>
                    x.Integration.Integration == integration.Integration
                    && x.Integration.Device == integration.Device
                );
    }

    public async Task<ElectricityMeter?> FindElectricityMeter(IntegrationIdentifier integration)
    {
        var local = _context.ElectricityMeters.Local.SingleOrDefault(x =>
            x.Integration == integration
        );

        return local
            ?? await _context
                .ElectricityMeters.IgnoreQueryFilters()
                .SingleOrDefaultAsync(x =>
                    x.Integration.Integration == integration.Integration
                    && x.Integration.Device == integration.Device
                );
    }
}
