using Emma.Domain;
using Emma.Domain.Consumers;

namespace Emma.Integrations.Shared;

public interface ISwitchConsumerIntegration
{
    IntegrationId IntegrationId { get; }
    Task Switch(IntegrationIdentifier integrationIdentifier, SwitchStatus status);
}
