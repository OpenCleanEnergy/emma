using crozone.AsyncResetEvents;

namespace OpenEMS.Infrastructure.Integrations.Shelly;

public sealed class ShellyHostsAutoResetEvent
{
    private readonly AsyncAutoResetEvent _asyncAutoResetEvent = new(false);

    public static ShellyHostsAutoResetEvent Instance { get; } = new();

    public Task WaitAsync(CancellationToken cancellationToken) =>
        _asyncAutoResetEvent.WaitAsync(cancellationToken);

    public void Set() => _asyncAutoResetEvent.Set();
}
