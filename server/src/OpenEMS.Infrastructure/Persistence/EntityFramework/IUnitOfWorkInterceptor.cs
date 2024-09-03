namespace OpenEMS.Infrastructure.Persistence.EntityFramework;

public interface IUnitOfWorkInterceptor
{
    Task UnitOfWorkCompleted(AppDbContext dbContext);
}
