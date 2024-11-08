using DotNext.Threading;

namespace OpenEMS.Infrastructure.Integrations.Shelly;

public sealed class ShellyHostsAutoResetEvent : IDisposable
{
    private readonly AsyncAutoResetEvent _asyncAutoResetEvent = new(false);

    public static ShellyHostsAutoResetEvent Instance { get; } = new();

    public ValueTask WaitAsync(CancellationToken cancellationToken) =>
        _asyncAutoResetEvent.WaitAsync(cancellationToken);

    public void Set() => _asyncAutoResetEvent.Set();

    public void Dispose()
    {
        _asyncAutoResetEvent.Dispose();
    }
}
