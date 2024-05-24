using System.Data.Common;
using Emma.Application.Shared.Events;
using Emma.Domain.Events;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

namespace Emma.Infrastructure.Persistence.EntityFramework;

public class EntityFrameworkEventPublisherInterceptor
    : ISaveChangesInterceptor,
        IDbTransactionInterceptor
{
    private readonly HashSet<IHasEvents> _entitiesWithEvents = [];
    private readonly IEventPublisher _eventPublisher;

    public EntityFrameworkEventPublisherInterceptor(IEventPublisher eventPublisher)
    {
        _eventPublisher = eventPublisher;
    }

    public InterceptionResult<int> SavingChanges(
        DbContextEventData eventData,
        InterceptionResult<int> result
    )
    {
        CaptureEntitiesWithEvents(eventData.Context);
        return result;
    }

    public ValueTask<InterceptionResult<int>> SavingChangesAsync(
        DbContextEventData eventData,
        InterceptionResult<int> result,
        CancellationToken cancellationToken = default
    )
    {
        CaptureEntitiesWithEvents(eventData.Context);
        return ValueTask.FromResult(result);
    }

    public int SavedChanges(SaveChangesCompletedEventData eventData, int result)
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            PublishAndClearEvents().GetAwaiter().GetResult();
        }

        return result;
    }

    public async ValueTask<int> SavedChangesAsync(
        SaveChangesCompletedEventData eventData,
        int result,
        CancellationToken cancellationToken = default
    )
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            await PublishAndClearEvents();
        }

        return result;
    }

    public void TransactionCommitted(DbTransaction transaction, TransactionEndEventData eventData)
    {
        PublishAndClearEvents().GetAwaiter().GetResult();
    }

    public async Task TransactionCommittedAsync(
        DbTransaction transaction,
        TransactionEndEventData eventData,
        CancellationToken cancellationToken = default
    )
    {
        await PublishAndClearEvents();
    }

    private void CaptureEntitiesWithEvents(DbContext? dbContext)
    {
        ArgumentNullException.ThrowIfNull(dbContext);

        var entitiesWithEvents = dbContext
            .ChangeTracker.Entries<IHasEvents>()
            .Select(entry => entry.Entity)
            .Where(entity => entity.HasEvents());

        foreach (var entity in entitiesWithEvents)
        {
            _entitiesWithEvents.Add(entity);
        }
    }

    private async Task PublishAndClearEvents()
    {
        foreach (var entity in _entitiesWithEvents)
        {
            await _eventPublisher.Publish(entity);
            entity.ClearEvents();
        }

        _entitiesWithEvents.Clear();
    }
}
