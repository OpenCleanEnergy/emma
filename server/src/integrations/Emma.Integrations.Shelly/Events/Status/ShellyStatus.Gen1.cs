namespace Emma.Integrations.Shelly.Events.Status;

public partial class ShellyStatus
{
    public IReadOnlyList<ShellyRelayStatus> Relays { get; init; } = [];

    public IReadOnlyList<ShellyMeterStatus> Meters { get; init; } = [];

    public IReadOnlyList<ShellyEMeterStatus> EMeters { get; init; } = [];
}
