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
    private readonly IEventPublisher _eventPublisher;

    public EntityFrameworkEventPublisherInterceptor(IEventPublisher eventPublisher)
    {
        _eventPublisher = eventPublisher;
    }

    public int SavedChanges(SaveChangesCompletedEventData eventData, int result)
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            PublishAndClearEvents(eventData.Context).GetAwaiter().GetResult();
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
            await PublishAndClearEvents(eventData.Context);
        }

        return result;
    }

    public void TransactionCommitted(DbTransaction transaction, TransactionEndEventData eventData)
    {
        PublishAndClearEvents(eventData.Context).GetAwaiter().GetResult();
    }

    public async Task TransactionCommittedAsync(
        DbTransaction transaction,
        TransactionEndEventData eventData,
        CancellationToken cancellationToken = default
    )
    {
        await PublishAndClearEvents(eventData.Context);
    }

    private async Task PublishAndClearEvents(DbContext? dbContext)
    {
        ArgumentNullException.ThrowIfNull(dbContext);

        var entitiesWithEvents = dbContext
            .ChangeTracker.Entries<IHasEvents>()
            .Select(entry => entry.Entity)
            .Where(entity => entity.HasEvents());

        foreach (var entity in entitiesWithEvents)
        {
            await _eventPublisher.Publish(entity);
            entity.ClearEvents();
        }
    }
}
