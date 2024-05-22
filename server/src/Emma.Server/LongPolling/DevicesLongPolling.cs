using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Producers;

namespace Emma.Server.LongPolling;

public class DevicesLongPolling : TypeBasedLongPolling
{
    public DevicesLongPolling(TimeProvider timeProvider)
        : base(timeProvider) { }

    public override IReadOnlySet<Type> WatchedTypes { get; } =
        new HashSet<Type>() { typeof(SwitchConsumer), typeof(Producer), typeof(ElectricityMeter) };
}
