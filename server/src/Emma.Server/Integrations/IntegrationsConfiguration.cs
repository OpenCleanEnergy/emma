using Emma.Integrations.Shelly;

namespace Emma.Server.Integrations;

public class IntegrationsConfiguration
{
    public required ShellyIntegrationConfiguration Shelly { get; init; }
}
