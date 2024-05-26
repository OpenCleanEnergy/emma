using NMolecules.DDD;

namespace Emma.Domain.Producers;

[Repository]
public interface IProducerRepository
{
    void Add(Producer producer);
    Task Delete(ProducerId id);
    Task<Producer?> FindBy(ProducerId id);
    Task<IReadOnlyCollection<Producer>> GetAll();
}
