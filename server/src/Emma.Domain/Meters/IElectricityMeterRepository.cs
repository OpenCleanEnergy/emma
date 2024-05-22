namespace Emma.Domain.Meters;

public interface IElectricityMeterRepository
{
    void Add(ElectricityMeter electricityMeter);
    Task Delete(ElectricityMeterId id);
    Task<ElectricityMeter?> FindBy(ElectricityMeterId id);
    Task<IReadOnlyCollection<ElectricityMeter>> GetAll();
}
