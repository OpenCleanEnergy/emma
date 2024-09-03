namespace OpenEMS.Domain;

public static class AmbientTimeProvider
{
    public static TimeProvider Current => AmbientTimeProviderTest.Current ?? TimeProvider.System;

    public static DateTimeOffset UtcNow => Current.GetUtcNow();
}
