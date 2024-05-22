using Emma.Domain;
using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Producers;

namespace Emma.Integrations.Shared;

public interface IDevicesRepository
{
    Task<SwitchConsumer?> FindSwitchConsumer(IntegrationIdentifier integration);
    Task<Producer?> FindProducer(IntegrationIdentifier integration);
    Task<ElectricityMeter?> FindElectricityMeter(IntegrationIdentifier integration);
}
