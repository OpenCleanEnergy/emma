using Emma.Domain.Events;

namespace Emma.Integrations.Shelly.Events;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/integrator-api/communication#shellysettings.
/// </summary>
public class ShellySettingsEvent : ShellyEvent
{
    public override EventKey EventKey { get; } = "emma.integrations.shelly.settings";
}
