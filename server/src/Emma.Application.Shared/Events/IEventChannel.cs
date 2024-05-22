namespace Emma.Application.Shared.Events;

public interface IEventChannel
{
    public abstract string Name { get; }
    public abstract int PrefetchCount { get; }
}
