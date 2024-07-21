namespace OpenEMS.Domain;

public interface IHasOwner
{
    UserId OwnedBy { get; init; }
}
