using NMolecules.DDD;

namespace OpenEMS.Domain.Consumers;

[ValueObject]
public enum SwitchActor
{
    User,
    Automation,
    Integration,
}
