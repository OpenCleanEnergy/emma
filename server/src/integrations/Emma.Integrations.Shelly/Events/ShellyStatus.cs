namespace Emma.Integrations.Shelly.Events;

public class ShellyStatus
{
    public IReadOnlyList<ShellyRelayStatus> Relays { get; init; } = [];

    public IReadOnlyList<ShellyMeterStatus> Meters { get; init; } = [];

    public IReadOnlyList<ShellyEMeterStatus> EMeters { get; init; } = [];
}
