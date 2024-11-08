using System.Collections.Concurrent;
using DotNext.Collections.Generic;
using DotNext.Threading;
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
        LongPollingSession session,
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
            await sessions.Wait(session, cts.Token);
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
        private readonly Dictionary<LongPollingSession, LongPollingSessionItem> _eventsBySession =
        [];

        public async Task Wait(LongPollingSession session, CancellationToken cancellationToken)
        {
            LongPollingSessionItem item;
            lock (_lock)
            {
                item = _eventsBySession.GetOrAdd(session, _ => new LongPollingSessionItem());
            }

            item.LastWait = _timeProvider.GetUtcNow();
            await item.AsyncAutoResetEvent.WaitAsync(cancellationToken);
        }

        public void Notify()
        {
            lock (_lock)
            {
                var sessions = _eventsBySession.Keys.ToArray();
                var now = _timeProvider.GetUtcNow();
                foreach (var session in sessions)
                {
                    var item = _eventsBySession[session];
                    if (item.LastWait.AddMinutes(5) < now)
                    {
                        _eventsBySession.Remove(session);
                        item.AsyncAutoResetEvent.Dispose();
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
