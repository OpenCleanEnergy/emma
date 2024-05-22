using crozone.AsyncResetEvents;

namespace Emma.Infrastructure;

public class ShellyHostsAutoResetEvent
{
    private readonly AsyncAutoResetEvent _asyncAutoResetEvent;

    private ShellyHostsAutoResetEvent()
    {
        _asyncAutoResetEvent = new AsyncAutoResetEvent();
        _asyncAutoResetEvent.WaitAsync();
    }

    public static ShellyHostsAutoResetEvent Instance { get; } = new();

    public Task WaitAsync(CancellationToken cancellationToken) =>
        _asyncAutoResetEvent.WaitAsync(cancellationToken);

    public void Set() => _asyncAutoResetEvent.Set();
}
