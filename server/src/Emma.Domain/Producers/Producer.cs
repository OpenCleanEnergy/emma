using Emma.Domain.Events;
using Emma.Domain.Units;
using NMolecules.DDD;

namespace Emma.Domain.Producers;

[AggregateRoot]
public class Producer : IHasOwner, IHasEvents
{
    private readonly List<IEvent> _events = [];

    [Identity]
    public ProducerId Id { get; private set; } = ProducerId.NewId();

    public required DeviceName Name { get; set; }

    public required IntegrationIdentifier Integration { get; init; }

    public Watt CurrentPowerProduction { get; private set; } = Watt.Zero;
    public Watt MaximumPowerProduction { get; private set; } = Watt.Zero;
    public WattHours TotalEnergyProduction { get; private set; } = WattHours.Zero;
    public required UserId OwnedBy { get; init; }

    public void ReportCurrentPowerProduction(Watt value)
    {
        CurrentPowerProduction = value;
        if (MaximumPowerProduction < value)
        {
            MaximumPowerProduction = value;
        }
    }

    public void ReportTotalEnergyProduction(WattHours value)
    {
        TotalEnergyProduction = value;
    }

    public bool HasEvents() => _events.Count > 0;

    public IReadOnlyList<IEvent> GetEvents() => _events.AsReadOnly();

    public void ClearEvents() => _events.Clear();
}
