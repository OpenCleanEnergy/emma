using System.Collections.Concurrent;
using System.Collections.Immutable;
using Emma.Domain;

namespace Emma.Server.LongPolling;

public abstract class TypeBasedLongPolling
{
    private static readonly TimeSpan _timeout = TimeSpan.FromSeconds(30);

    private readonly ConcurrentDictionary<
        UserId,
        ImmutableList<TaskCompletionSource>
    > _subscriptions = [];

    private readonly TimeProvider _timeProvider;

    protected TypeBasedLongPolling(TimeProvider timeProvider)
    {
        _timeProvider = timeProvider;
    }

    public abstract IReadOnlySet<Type> WatchedTypes { get; }

    public virtual async Task WaitForUpdates(UserId userId, CancellationToken cancellationToken)
    {
        var tcs = new TaskCompletionSource();
        _subscriptions.AddOrUpdate(userId, _ => [tcs], (_, list) => list.Add(tcs));

        await Task.WhenAny(tcs.Task, Task.Delay(_timeout, _timeProvider, cancellationToken));
    }

    public virtual void Notify(UserId userId)
    {
        if (!_subscriptions.TryRemove(userId, out var subscriptions))
        {
            return;
        }

        foreach (var subscription in subscriptions)
        {
            subscription.TrySetResult();
        }
    }
}
