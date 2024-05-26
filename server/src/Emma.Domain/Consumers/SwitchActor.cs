using NMolecules.DDD;

namespace Emma.Domain.Consumers;

[ValueObject]
public enum SwitchActor
{
    User,
    Automation,
    Integration,
}
