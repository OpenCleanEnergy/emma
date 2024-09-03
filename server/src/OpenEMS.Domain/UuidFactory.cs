using Medo;

namespace OpenEMS.Domain;

internal static class UuidFactory
{
    public static Guid NewSequentialGuid() => Uuid7.NewGuid();
}
