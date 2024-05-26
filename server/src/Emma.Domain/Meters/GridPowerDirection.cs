using NMolecules.DDD;

namespace Emma.Domain.Meters;

[ValueObject]
public enum GridPowerDirection
{
    None,
    Consume,
    FeedIn
}
