namespace Emma.Domain.Producers;

public interface IProducerRepository
{
    void Add(Producer producer);
    Task Delete(ProducerId id);
    Task<Producer?> FindBy(ProducerId id);
    Task<IReadOnlyCollection<Producer>> GetAll();
}
