namespace Emma.Application.Shared;

public interface IUnitOfWork
{
    Task SaveChanges();
}
