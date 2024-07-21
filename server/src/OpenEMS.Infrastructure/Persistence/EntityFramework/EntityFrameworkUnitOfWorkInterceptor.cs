using System.Data.Common;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework;

public class EntityFrameworkUnitOfWorkInterceptor
    : ISaveChangesInterceptor,
        IDbTransactionInterceptor
{
    private readonly IEnumerable<IUnitOfWorkInterceptor> _unitOfWorkInterceptors;

    public EntityFrameworkUnitOfWorkInterceptor(
        IEnumerable<IUnitOfWorkInterceptor> unitOfWorkInterceptors
    )
    {
        _unitOfWorkInterceptors = unitOfWorkInterceptors;
    }

    public int SavedChanges(SaveChangesCompletedEventData eventData, int result)
    {
        if (eventData.Context?.Database.CurrentTransaction is null)
        {
            CallInterceptors(eventData.Context).GetAwaiter().GetResult();
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
            CallInterceptors(eventData.Context).GetAwaiter().GetResult();
        }

        return new ValueTask<int>(result);
    }

    public void TransactionCommitted(DbTransaction transaction, TransactionEndEventData eventData)
    {
        CallInterceptors(eventData.Context).GetAwaiter().GetResult();
    }

    public async Task TransactionCommittedAsync(
        DbTransaction transaction,
        TransactionEndEventData eventData,
        CancellationToken cancellationToken = default
    )
    {
        await CallInterceptors(eventData.Context);
    }

    private async Task CallInterceptors(DbContext? dbContext)
    {
        if (dbContext is not AppDbContext appDbContext)
        {
            throw new ArgumentException(
                $"Expected {nameof(dbContext)} to be of type {typeof(AppDbContext).Name} but got {dbContext?.GetType().Name ?? "null"}."
            );
        }

        foreach (var interceptor in _unitOfWorkInterceptors)
        {
            await interceptor.UnitOfWorkCompleted(appDbContext);
        }
    }
}
