using Medo;

namespace Emma.Domain;

internal static class UuidFactory
{
    public static Guid NewSequentialGuid() => Uuid7.NewGuid();
}
