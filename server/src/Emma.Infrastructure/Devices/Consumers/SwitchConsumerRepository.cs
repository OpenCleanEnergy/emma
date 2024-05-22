using Emma.Domain.Consumers;
using Emma.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure.Devices.Consumers;

public class SwitchConsumerRepository : ISwitchConsumerRepository
{
    private readonly DbSet<SwitchConsumer> _set;

    public SwitchConsumerRepository(AppDbContext context)
    {
        _set = context.SwitchConsumers;
    }

    public void Add(SwitchConsumer switchConsumer)
    {
        _set.Add(switchConsumer);
    }

    public async Task Delete(SwitchConsumerId id)
    {
        var delete = await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
        if (delete is not null)
        {
            _set.Remove(delete);
        }
    }

    public async Task<SwitchConsumer?> FindBy(SwitchConsumerId id)
    {
        return await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
    }

    public async Task<IReadOnlyCollection<SwitchConsumer>> GetAll()
    {
        return await _set.ToArrayAsync();
    }
}
