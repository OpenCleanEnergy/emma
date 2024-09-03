using Microsoft.EntityFrameworkCore;
using OpenEMS.Domain.Producers;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Devices.Producers;

public class ProducerRepository : IProducerRepository
{
    private readonly DbSet<Producer> _set;

    public ProducerRepository(AppDbContext context)
    {
        _set = context.Producers;
    }

    public void Add(Producer producer)
    {
        _set.Add(producer);
    }

    public async Task Delete(ProducerId id)
    {
        var delete = await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
        if (delete is not null)
        {
            _set.Remove(delete);
        }
    }

    public async Task<Producer?> FindBy(ProducerId id)
    {
        return await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
    }

    public async Task<IReadOnlyCollection<Producer>> GetAll()
    {
        return await _set.ToArrayAsync();
    }
}
