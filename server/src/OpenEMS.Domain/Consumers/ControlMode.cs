using NMolecules.DDD;

namespace OpenEMS.Domain.Consumers;

[ValueObject]
public enum ControlMode
{
    Manual,
    Smart
}
