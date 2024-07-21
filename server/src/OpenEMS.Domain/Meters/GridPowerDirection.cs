using NMolecules.DDD;

namespace OpenEMS.Domain.Meters;

[ValueObject]
public enum GridPowerDirection
{
    None,
    Consume,
    FeedIn
}
