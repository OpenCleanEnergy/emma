using Emma.Domain.Events;
using Emma.Domain.Units;
using NMolecules.DDD;

namespace Emma.Domain.Meters;

[AggregateRoot]
public class ElectricityMeter : IHasOwner, IHasEvents
{
    private readonly List<IEvent> _events = [];

    [Identity]
    public ElectricityMeterId Id { get; private set; } = ElectricityMeterId.NewId();
    public required DeviceName Name { get; set; }

    public required IntegrationIdentifier Integration { get; init; }

    public GridPowerDirection CurrentPowerDirection { get; private set; } = GridPowerDirection.None;
    public Watt CurrentPower { get; private set; } = Watt.Zero;
    public Watt MaximumPowerConsumption { get; private set; } = Watt.Zero;
    public Watt MaximumPowerFeedIn { get; private set; } = Watt.Zero;
    public WattHours TotalEnergyConsumption { get; set; } = WattHours.Zero;
    public WattHours TotalEnergyFeedIn { get; set; } = WattHours.Zero;
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

    public bool HasEvents() => _events.Count > 0;

    public IReadOnlyList<IEvent> GetEvents() => _events.AsReadOnly();

    public void ClearEvents() => _events.Clear();
}
