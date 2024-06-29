using Emma.Application.Shared;
using Emma.Application.Shared.Events;
using Emma.Domain.Events;

namespace Emma.Infrastructure.Persistence;

public class UnitOfWork : IUnitOfWork
{
    private readonly AppDbContext _dbContext;
    private readonly IEventPublisher _eventPublisher;

    public UnitOfWork(AppDbContext dbContext, IEventPublisher eventPublisher)
    {
        _dbContext = dbContext;
        _eventPublisher = eventPublisher;
    }

    public async Task SaveChanges()
    {
        var entitiesWithEvents = _dbContext
            .ChangeTracker.Entries<IHasEvents>()
            .Select(entry => entry.Entity)
            .ToArray();

        await _dbContext.SaveChangesAsync();

        foreach (var entity in entitiesWithEvents)
        {
            await _eventPublisher.Publish(entity);
        }
    }
}
