using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;

namespace OpenEMS.Integrations.Shared;

public interface ISwitchConsumerIntegration
{
    IntegrationId IntegrationId { get; }
    Task Switch(IntegrationIdentifier integrationIdentifier, SwitchStatus status);
}
