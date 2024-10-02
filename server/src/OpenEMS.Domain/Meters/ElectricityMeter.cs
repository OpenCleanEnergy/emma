using NMolecules.DDD;
using OpenEMS.Domain.Events;
using OpenEMS.Domain.Units;

namespace OpenEMS.Domain.Meters;

[AggregateRoot]
public class ElectricityMeter : IHasOwner, IHasEvents
{
    private readonly List<IEvent> _events = [];

    [Identity]
    public ElectricityMeterId Id { get; private set; } = ElectricityMeterId.NewId();
    public required DeviceName Name { get; set; }

    public required IntegrationIdentifier Integration { get; init; }

    public GridPowerDirection CurrentPowerDirection { get; private set; } = GridPowerDirection.None;
    public Watt? CurrentPower { get; private set; }
    public Watt? MaximumPowerConsumption { get; private set; }
    public Watt? MaximumPowerFeedIn { get; private set; }
    public TotalEnergy? TotalEnergyConsumption { get; private set; }
    public TotalEnergy? TotalEnergyFeedIn { get; private set; }
    public required UserId OwnedBy { get; init; }

    public void ReportCurrentPower(Watt currentPower, GridPowerDirection currentPowerDirection)
    {
        if (currentPowerDirection == GridPowerDirection.None && currentPower != Watt.Zero)
        {
            throw new ArgumentException(
                $"Power direction {currentPowerDirection} is not allowed with current power of {currentPower}."
            );
        }

        if (currentPowerDirection != GridPowerDirection.None && currentPower == Watt.Zero)
        {
            throw new ArgumentException(
                $"Power direction {currentPowerDirection} is not allowed with current power of {currentPower}. Expected power direction {GridPowerDirection.None}."
            );
        }

        CurrentPower = currentPower.Abs();
        CurrentPowerDirection = currentPowerDirection;
        MaximumPowerConsumption ??= Watt.Zero;
        MaximumPowerFeedIn ??= Watt.Zero;

        switch (CurrentPowerDirection)
        {
            case GridPowerDirection.None:
                break;
            case GridPowerDirection.Consume:
                if (MaximumPowerConsumption < CurrentPower)
                {
                    MaximumPowerConsumption = CurrentPower;
                }

                break;
            case GridPowerDirection.FeedIn:
                if (MaximumPowerFeedIn < CurrentPower)
                {
                    MaximumPowerFeedIn = CurrentPower;
                }

                break;
            default:
                throw Exceptions.NotImplemented(CurrentPowerDirection);
        }
    }

    public void ReportTotalEnergyConsumption(WattHours value) =>
        TotalEnergyConsumption = (TotalEnergyConsumption ?? TotalEnergy.Zero).WithReported(value);

    public void ReportTotalEnergyFeedIn(WattHours value) =>
        TotalEnergyFeedIn = (TotalEnergyFeedIn ?? TotalEnergy.Zero).WithReported(value);

    public bool HasEvents() => _events.Count > 0;

    public IReadOnlyList<IEvent> GetEvents() => _events.AsReadOnly();

    public void ClearEvents() => _events.Clear();
}
