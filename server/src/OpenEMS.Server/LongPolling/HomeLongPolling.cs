using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Server.LongPolling;

public class HomeLongPolling(TimeProvider timeProvider) : TypeBasedLongPolling(timeProvider)
{
    public override IReadOnlySet<Type> WatchedTypes { get; } =
        new HashSet<Type>() { typeof(SwitchConsumer), typeof(Producer), typeof(ElectricityMeter) };
}
