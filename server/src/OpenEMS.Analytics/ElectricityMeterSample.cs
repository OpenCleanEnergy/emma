using OpenEMS.Domain;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics;

public class ElectricityMeterSample : IHasOwner
{
    public required ElectricityMeterId ElectricityMeterId { get; init; }
    public required DateTimeOffset Timestamp { get; init; }

    /// <summary>
    /// Gets the <see cref="ElectricityMeter.CurrentPower"/>.
    /// </summary>
    public required Watt? CurrentPower { get; init; }

    /// <summary>
    /// Gets the <see cref="ElectricityMeter.CurrentPowerDirection"/>.
    /// </summary>
    public required GridPowerDirection CurrentPowerDirection { get; init; }

    /// <summary>
    /// Gets the <see cref="ElectricityMeter.TotalEnergyConsumption"/>.
    /// </summary>
    public required WattHours? TotalEnergyConsumption { get; init; }

    /// <summary>
    /// Gets the <see cref="ElectricityMeter.TotalEnergyFeedIn"/>.
    /// </summary>
    public required WattHours? TotalEnergyFeedIn { get; init; }

    /// <summary>
    /// Gets the <see cref="ElectricityMeter.OwnedBy"/>.
    /// </summary>
    public required UserId OwnedBy { get; init; }
}
