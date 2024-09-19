using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics;

public class SwitchConsumerSample : IHasOwner
{
    public required SwitchConsumerId SwitchConsumerId { get; init; }
    public required DateTimeOffset Timestamp { get; init; }

    /// <summary>
    /// Gets the <see cref="SwitchConsumer.CurrentPowerConsumption"/>.
    /// </summary>
    public required Watt CurrentPowerConsumption { get; init; }

    /// <summary>
    /// Gets the <see cref="SwitchConsumer.TotalEnergyConsumption"/>.
    /// </summary>
    public required WattHours TotalEnergyConsumption { get; init; }

    /// <summary>
    /// Gets the <see cref="SwitchConsumer.OwnedBy"/>.
    /// </summary>
    public required UserId OwnedBy { get; init; }
}
