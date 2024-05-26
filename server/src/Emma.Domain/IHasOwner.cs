namespace Emma.Domain;

public interface IHasOwner
{
    UserId OwnedBy { get; init; }
}
