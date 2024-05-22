using Emma.Domain.Meters;
using Emma.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure.Devices.Meters;

public class ElectricityMeterRepository : IElectricityMeterRepository
{
    private readonly DbSet<ElectricityMeter> _set;

    public ElectricityMeterRepository(AppDbContext context)
    {
        _set = context.ElectricityMeters;
    }

    public void Add(ElectricityMeter electricityMeter)
    {
        _set.Add(electricityMeter);
    }

    public async Task Delete(ElectricityMeterId id)
    {
        var delete = await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
        if (delete is not null)
        {
            _set.Remove(delete);
        }
    }

    public async Task<ElectricityMeter?> FindBy(ElectricityMeterId id)
    {
        return await _set.Where(x => x.Id == id).SingleOrDefaultAsync();
    }

    public async Task<IReadOnlyCollection<ElectricityMeter>> GetAll()
    {
        return await _set.ToArrayAsync();
    }
}
