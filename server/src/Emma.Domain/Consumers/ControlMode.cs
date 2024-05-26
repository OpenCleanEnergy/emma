using NMolecules.DDD;

namespace Emma.Domain.Consumers;

[ValueObject]
public enum ControlMode
{
    Manual,
    Smart
}
