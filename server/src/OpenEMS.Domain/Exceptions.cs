namespace OpenEMS.Domain;

public static class Exceptions
{
    public static NotImplementedException NotImplemented<T>(T value) =>
        new($"{typeof(T).Name} '{value}' is not implemented");
}
