using crozone.AsyncResetEvents;

namespace OpenEMS.Infrastructure;

public class ShellyHostsAutoResetEvent
{
    private readonly AsyncAutoResetEvent _asyncAutoResetEvent;

    private ShellyHostsAutoResetEvent()
    {
        _asyncAutoResetEvent = new AsyncAutoResetEvent();
    }

    public static ShellyHostsAutoResetEvent Instance { get; } = new();

    public Task WaitAsync(CancellationToken cancellationToken) =>
        _asyncAutoResetEvent.WaitAsync(cancellationToken);

    public void Set() => _asyncAutoResetEvent.Set();
}
