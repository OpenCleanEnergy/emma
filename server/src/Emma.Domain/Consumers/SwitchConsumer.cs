using Emma.Domain.Consumers.Events;
using Emma.Domain.Events;
using Emma.Domain.Units;

namespace Emma.Domain.Consumers;

/// <summary>
/// Represents a consumer that can be switched on or off.
/// </summary>
public class SwitchConsumer : IHasOwner, IHasEvents
{
    private readonly List<IEvent> _events = [];
    public SwitchConsumerId Id { get; private set; } = SwitchConsumerId.NewId();

    public required DeviceName Name { get; set; }

    public required IntegrationIdentifier Integration { get; init; }

    public ControlMode Mode { get; private set; }
    public SwitchConsumerSmartModeConfiguration SmartModeConfiguration { get; set; } =
        SwitchConsumerSmartModeConfiguration.Default;

    public SwitchStatus SwitchStatus { get; private set; }
    public Watt CurrentPowerConsumption { get; private set; } = Watt.Zero;
    public Watt MaximumPowerConsumption { get; private set; } = Watt.Zero;
    public WattHours TotalEnergyConsumption { get; private set; } = WattHours.Zero;
    public required UserId OwnedBy { get; init; }

    public void ActivateSmartMode()
    {
        Mode = ControlMode.Smart;
    }

    public void Switch(SwitchStatus status, SwitchActor actor)
    {
        if (SwitchStatus == status)
        {
            return;
        }

        if (actor == SwitchActor.User)
        {
            Mode = ControlMode.Manual;
        }

        SwitchStatus = status;
        _events.Add(new SwitchConsumerSwitchedEvent(Id, Integration, SwitchStatus, actor));
    }

    public void ReportCurrentPowerConsumption(Watt value)
    {
        CurrentPowerConsumption = value;
        if (MaximumPowerConsumption < value)
        {
            MaximumPowerConsumption = value;
        }
    }

    public void ReportTotalEnergyConsumption(WattHours value)
    {
        TotalEnergyConsumption = value;
    }

    public bool HasEvents() => _events.Count > 0;

    public IReadOnlyList<IEvent> GetEvents() => _events.AsReadOnly();

    public void ClearEvents() => _events.Clear();
}
