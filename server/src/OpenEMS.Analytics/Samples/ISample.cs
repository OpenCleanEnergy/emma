using OpenEMS.Domain;

namespace OpenEMS.Analytics.Samples;

public interface ISample : IHasOwner
{
    DateTimeOffset Timestamp { get; init; }
}
