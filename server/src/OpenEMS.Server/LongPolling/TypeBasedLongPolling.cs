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
        var sessions = GetClients(userId);

        // IMPORTANT: use linked token source to cancel the long polling after 30 seconds
        // otherwise the `Wait` on the `AsyncAutoResetEvent` will not be released
        using var cts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
        cts.CancelAfter(_timeout);
        try
        {
            await sessions.WaitForUpdates(session, cts.Token);
        }
        catch (OperationCanceledException ex) when (ex.CancellationToken == cts.Token)
        {
            // long polling timeout or cancellation
        }
    }

    public virtual void Notify(UserId userId)
    {
        var sessions = GetClients(userId);
        sessions.Notify();
    }

    private LongPollingSessions GetClients(UserId userId)
    {
        return _sessionsByUserId.GetOrAdd(userId, _ => new LongPollingSessions(_timeProvider));
    }

    private sealed class LongPollingSessions(TimeProvider timeProvider)
    {
        private readonly TimeProvider _timeProvider = timeProvider;
        private readonly object _lock = new();
        private readonly Dictionary<
            LongPollingSession,
            AsyncAutoResetEventWithTimestamp
        > _eventsBySession = [];

        public async Task WaitForUpdates(
            LongPollingSession session,
            CancellationToken cancellationToken
        )
        {
            AsyncAutoResetEventWithTimestamp autoResetEvent;
            lock (_lock)
            {
                autoResetEvent = _eventsBySession.GetOrAdd(
                    session,
                    _ => new AsyncAutoResetEventWithTimestamp(_timeProvider)
                );
            }

            await autoResetEvent.WaitAsync(cancellationToken);
        }

        public void Notify()
        {
            lock (_lock)
            {
                var sessions = _eventsBySession.Keys.ToArray();
                var now = _timeProvider.GetUtcNow();
                foreach (var session in sessions)
                {
                    var autoResetEvent = _eventsBySession[session];
                    if (autoResetEvent.LastWait.AddMinutes(5) < now)
                    {
                        _eventsBySession.Remove(session);
                        autoResetEvent.Dispose();
                    }
                    else
                    {
                        autoResetEvent.Set();
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
