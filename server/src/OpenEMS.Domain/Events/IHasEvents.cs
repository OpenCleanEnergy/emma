namespace OpenEMS.Domain.Events;

public interface IHasEvents
{
    bool HasEvents();
    IReadOnlyList<IEvent> GetEvents();
    void ClearEvents();
}
