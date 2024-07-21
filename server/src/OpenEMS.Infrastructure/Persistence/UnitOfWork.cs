using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;

namespace OpenEMS.Infrastructure.Persistence;

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
