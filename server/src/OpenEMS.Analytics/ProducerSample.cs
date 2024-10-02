using OpenEMS.Domain;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics;

public class ProducerSample : IHasOwner
{
    public required ProducerId ProducerId { get; init; }
    public required DateTimeOffset Timestamp { get; init; }

    /// <summary>
    /// Gets the <see cref="Producer.CurrentPowerProduction"/>.
    /// </summary>
    public required Watt? CurrentPowerProduction { get; init; }

    /// <summary>
    /// Gets the <see cref="Producer.TotalEnergyProduction"/>.
    /// </summary>
    public required WattHours? TotalEnergyProduction { get; init; }

    /// <summary>
    /// Gets the <see cref="Producer.OwnedBy"/>.
    /// </summary>
    public required UserId OwnedBy { get; init; }
}
