using System.Collections.Concurrent;
using crozone.AsyncResetEvents;
using OpenEMS.Domain;

namespace OpenEMS.Server.LongPolling;

public abstract class TypeBasedLongPolling(TimeProvider timeProvider)
{
    private static readonly TimeSpan _timeout = TimeSpan.FromSeconds(30);

    private readonly ConcurrentDictionary<UserId, LongPollingSessions> _sessionsByUserId = [];

    private readonly TimeProvider _timeProvider = timeProvider;

    public abstract IReadOnlySet<Type> WatchedTypes { get; }

    public virtual async Task WaitForUpdatesOrTimeout(
        UserId userId,
        LongPollingSessionId sessionId,
        CancellationToken cancellationToken
    )
    {
        var sessions = GetSessions(userId);

        // IMPORTANT: use linked token source to cancel the long polling after 30 seconds
        // otherwise the `Wait` on the `AsyncAutoResetEvent` will not be released
        using var cts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
        cts.CancelAfter(_timeout);
        try
        {
            await sessions.Wait(sessionId, cts.Token);
        }
        catch (OperationCanceledException ex) when (ex.CancellationToken == cts.Token)
        {
            // long polling timeout or cancellation
        }
    }

    public virtual void Notify(UserId userId)
    {
        var sessions = GetSessions(userId);
        sessions.Notify();
    }

    private LongPollingSessions GetSessions(UserId userId)
    {
        return _sessionsByUserId.GetOrAdd(userId, _ => new LongPollingSessions(_timeProvider));
    }

    private sealed class LongPollingSessions(TimeProvider timeProvider)
    {
        private readonly TimeProvider _timeProvider = timeProvider;
        private readonly object _lock = new();
        private readonly Dictionary<LongPollingSessionId, LongPollingSessionItem> _eventsBySession =
            [];

        public async Task Wait(LongPollingSessionId sessionId, CancellationToken cancellationToken)
        {
            LongPollingSessionItem item;
            lock (_lock)
            {
                if (!_eventsBySession.TryGetValue(sessionId, out item!))
                {
                    item = _eventsBySession[sessionId] = new LongPollingSessionItem();
                }
            }

            item.LastWait = _timeProvider.GetUtcNow();
            await item.AsyncAutoResetEvent.WaitAsync(cancellationToken);
        }

        public void Notify()
        {
            lock (_lock)
            {
                var now = _timeProvider.GetUtcNow();

                var sessions = _eventsBySession.Keys.ToArray();
                foreach (var session in sessions)
                {
                    var item = _eventsBySession[session];
                    if (item.LastWait.AddDays(1) < now)
                    {
                        _eventsBySession.Remove(session);
                    }
                    else
                    {
                        item.AsyncAutoResetEvent.Set();
                    }
                }
            }
        }
    }

    private sealed class LongPollingSessionItem
    {
        public AsyncAutoResetEvent AsyncAutoResetEvent { get; } = new(false);

        public DateTimeOffset LastWait { get; set; }
    }
}
