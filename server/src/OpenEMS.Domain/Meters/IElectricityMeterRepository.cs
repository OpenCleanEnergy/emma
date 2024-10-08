using NMolecules.DDD;

namespace OpenEMS.Domain.Meters;

[Repository]
public interface IElectricityMeterRepository
{
    void Add(ElectricityMeter electricityMeter);
    Task Delete(ElectricityMeterId id);
    Task<ElectricityMeter?> FindBy(ElectricityMeterId id);
    Task<IReadOnlyCollection<ElectricityMeter>> GetAll();
}
