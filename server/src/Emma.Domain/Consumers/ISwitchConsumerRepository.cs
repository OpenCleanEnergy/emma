namespace Emma.Domain.Consumers;

public interface ISwitchConsumerRepository
{
    void Add(SwitchConsumer switchConsumer);
    Task Delete(SwitchConsumerId id);
    Task<SwitchConsumer?> FindBy(SwitchConsumerId id);
    Task<IReadOnlyCollection<SwitchConsumer>> GetAll();
}
