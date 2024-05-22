namespace Emma.Domain;

public sealed class AmbientTimeProviderTest : IDisposable
{
    private static readonly AsyncLocal<TimeProvider?> _current = new();

    public AmbientTimeProviderTest(TimeProvider timeProvider)
    {
        _current.Value = timeProvider;
    }

    public static TimeProvider? Current => _current.Value;

    public void Dispose()
    {
        _current.Value = null;
    }
}
