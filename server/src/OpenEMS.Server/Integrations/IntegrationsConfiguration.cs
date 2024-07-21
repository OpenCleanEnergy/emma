using OpenEMS.Integrations.Shelly;

namespace OpenEMS.Server.Integrations;

public class IntegrationsConfiguration
{
    public required ShellyIntegrationConfiguration Shelly { get; init; }
}
