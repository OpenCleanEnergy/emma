using NMolecules.DDD;
using OpenEMS.Domain.Events;
using OpenEMS.Domain.Units;

namespace OpenEMS.Domain.Producers;

[AggregateRoot]
public class Producer : IHasOwner, IHasEvents
{
    private readonly List<IEvent> _events = [];

    [Identity]
    public ProducerId Id { get; private set; } = ProducerId.NewId();

    public required DeviceName Name { get; set; }

    public required IntegrationIdentifier Integration { get; init; }

    public Watt? CurrentPowerProduction { get; private set; }
    public Watt? MaximumPowerProduction { get; private set; }
    public TotalEnergy? TotalEnergyProduction { get; private set; } = TotalEnergy.Zero;
    public required UserId OwnedBy { get; init; }

    public void ReportCurrentPowerProduction(Watt value)
    {
        CurrentPowerProduction = value;
        MaximumPowerProduction ??= Watt.Zero;
        if (MaximumPowerProduction < value)
        {
            MaximumPowerProduction = value;
        }
    }

    public void ReportTotalEnergyProduction(WattHours value)
    {
        TotalEnergyProduction = (TotalEnergyProduction ?? TotalEnergy.Zero).WithReported(value);
    }

    public bool HasEvents() => _events.Count > 0;

    public IReadOnlyList<IEvent> GetEvents() => _events.AsReadOnly();

    public void ClearEvents() => _events.Clear();
}
