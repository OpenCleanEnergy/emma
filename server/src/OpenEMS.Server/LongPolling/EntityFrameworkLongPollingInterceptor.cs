using System.Data.Common;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using OpenEMS.Domain;

namespace OpenEMS.Server.LongPolling;

public class EntityFrameworkLongPollingInterceptor<TLongPolling>
    : ISaveChangesInterceptor,
        IDbTransactionInterceptor
    where TLongPolling : TypeBasedLongPolling
{
    private readonly TLongPolling _longPolling;

    private readonly HashSet<UserId> _usersToNotify = [];

    public EntityFrameworkLongPollingInterceptor(TLongPolling longPolling)
    {
        _longPolling = longPolling;
    }

    public InterceptionResult<int> SavingChanges(
        DbContextEventData eventData,
        InterceptionResult<int> result
    )
    {
        CollectUsersToNotify(eventData.Context);
        return result;
    }

    public ValueTask<InterceptionResult<int>> SavingChangesAsync(
        DbContextEventData eventData,
        InterceptionResult<int> result,
        CancellationToken cancellationToken = default
    )
    {
        CollectUsersToNotify(eventData.Context);
        return new ValueTask<InterceptionResult<int>>(result);
    }

    public int SavedChanges(SaveChangesCompletedEventData eventData, int result)
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            Notify();
        }

        return result;
    }

    public ValueTask<int> SavedChangesAsync(
        SaveChangesCompletedEventData eventData,
        int result,
        CancellationToken cancellationToken = default
    )
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            Notify();
        }

        return new ValueTask<int>(result);
    }

    public void TransactionCommitted(DbTransaction transaction, TransactionEndEventData eventData)
    {
        Notify();
    }

    public Task TransactionCommittedAsync(
        DbTransaction transaction,
        TransactionEndEventData eventData,
        CancellationToken cancellationToken = default
    )
    {
        Notify();
        return Task.CompletedTask;
    }

    /// <summary>
    /// Collect users to notify BEFORE changes are saved
    /// to detect removed devices as well.
    /// </summary>
    private void CollectUsersToNotify(DbContext? dbContext)
    {
        ArgumentNullException.ThrowIfNull(dbContext);
        if (_usersToNotify.Count != 0)
        {
            throw new InvalidOperationException(
                $"Expected {nameof(_usersToNotify)} to be empty before starting to collect users."
            );
        }

        var devices = dbContext
            .ChangeTracker.Entries()
            .Select(entry => entry.Entity)
            .Where(IsWatched)
            .OfType<IHasOwner>();

        var userIds = devices.Select(x => x.OwnedBy);

        foreach (var userId in userIds)
        {
            _usersToNotify.Add(userId);
        }
    }

    private bool IsWatched(object entity)
    {
        var entityType = entity.GetType();
        return _longPolling.WatchedTypes.Any(watchedType =>
            watchedType.IsAssignableFrom(entityType)
        );
    }

    private void Notify()
    {
        foreach (var userId in _usersToNotify)
        {
            _longPolling.Notify(userId);
        }
    }
}
