using System.Collections.Concurrent;
using DotNext.Collections.Generic;
using DotNext.Threading;
using OpenEMS.Domain;

namespace OpenEMS.Server.LongPolling;

public abstract class TypeBasedLongPolling(TimeProvider timeProvider)
{
    private static readonly TimeSpan _timeout = TimeSpan.FromSeconds(30);

    private readonly ConcurrentDictionary<UserId, LongPollingClients> _clientsByUserId = [];

    private readonly TimeProvider _timeProvider = timeProvider;

    public abstract IReadOnlySet<Type> WatchedTypes { get; }

    public virtual async Task WaitForUpdates(
        UserId userId,
        int client,
        CancellationToken cancellationToken
    )
    {
        var clients = GetClients(userId);
        var wait = clients.WaitForUpdates(client, cancellationToken);

        await Task.WhenAny(wait, Task.Delay(_timeout, _timeProvider, cancellationToken));
    }

    public virtual void Notify(UserId userId)
    {
        var clients = GetClients(userId);
        clients.Notify();
    }

    private LongPollingClients GetClients(UserId userId)
    {
        return _clientsByUserId.GetOrAdd(userId, _ => new LongPollingClients(_timeProvider));
    }

    private sealed class LongPollingClients(TimeProvider timeProvider)
    {
        private readonly TimeProvider _timeProvider = timeProvider;
        private readonly object _lock = new();
        private readonly Dictionary<int, AsyncAutoResetEventWithTimestamp> _waitTrackingEvents = [];

        public async Task WaitForUpdates(int client, CancellationToken cancellationToken)
        {
            AsyncAutoResetEventWithTimestamp waitTrackingEvent;
            lock (_lock)
            {
                waitTrackingEvent = _waitTrackingEvents.GetOrAdd(
                    client,
                    _ => new AsyncAutoResetEventWithTimestamp(_timeProvider)
                );
            }

            await waitTrackingEvent.WaitAsync(cancellationToken);
        }

        public void Notify()
        {
            lock (_lock)
            {
                var sessions = _waitTrackingEvents.Keys.ToArray();
                var now = _timeProvider.GetUtcNow();
                foreach (var session in sessions)
                {
                    var waitTrackingEvent = _waitTrackingEvents[session];
                    if (waitTrackingEvent.LastWait.AddMinutes(5) < now)
                    {
                        _waitTrackingEvents.Remove(session);
                        waitTrackingEvent.Dispose();
                    }
                    else
                    {
                        waitTrackingEvent.Set();
                    }
                }
            }
        }
    }

    private sealed class AsyncAutoResetEventWithTimestamp(TimeProvider timeProvider) : IDisposable
    {
        private readonly TimeProvider _timeProvider = timeProvider;
        private readonly AsyncAutoResetEvent _autoResetEvent = new(false);

        public DateTimeOffset LastWait { get; private set; }

        public async Task WaitAsync(CancellationToken cancellationToken)
        {
            LastWait = _timeProvider.GetUtcNow();
            await _autoResetEvent.WaitAsync(cancellationToken);
        }

        public void Set()
        {
            _autoResetEvent.Set();
        }

        public void Dispose()
        {
            _autoResetEvent.Dispose();
        }
    }
}
