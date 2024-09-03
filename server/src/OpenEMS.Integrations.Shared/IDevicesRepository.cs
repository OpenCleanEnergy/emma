using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Integrations.Shared;

public interface IDevicesRepository
{
    Task<SwitchConsumer?> FindSwitchConsumer(IntegrationIdentifier integration);
    Task<Producer?> FindProducer(IntegrationIdentifier integration);
    Task<ElectricityMeter?> FindElectricityMeter(IntegrationIdentifier integration);
}
