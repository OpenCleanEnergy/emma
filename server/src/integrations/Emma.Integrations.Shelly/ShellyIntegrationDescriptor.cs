using Emma.Domain;
using Emma.Integrations.Shared;

namespace Emma.Integrations.Shelly;

public class ShellyIntegrationDescriptor : IIntegrationDescriptor
{
    private readonly ShellyIntegrationConfiguration _configuration;

    public ShellyIntegrationDescriptor(ShellyIntegrationConfiguration configuration)
    {
        _configuration = configuration;
    }

    public static IntegrationId Id { get; } = IntegrationId.From("shelly");
    public string Name { get; } = "Shelly";
    public bool IsEnabled => _configuration.IsEnabled && _configuration.Validate(out _);

    IntegrationId IIntegrationDescriptor.Id => Id;

    public bool Supports(DeviceCategory deviceCategory) => true;
}
