using Emma.Domain;

namespace Emma.Integrations.Shared;

public interface IIntegrationDescriptor
{
    IntegrationId Id { get; }
    string Name { get; }
    bool IsEnabled { get; }
    bool Supports(DeviceCategory deviceCategory);
}
