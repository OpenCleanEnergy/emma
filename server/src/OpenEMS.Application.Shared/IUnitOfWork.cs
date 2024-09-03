namespace OpenEMS.Application.Shared;

public interface IUnitOfWork
{
    Task SaveChanges();
}
