namespace Emma.Domain;

public interface IHasOwner
{
    public UserId OwnedBy { get; init; }
}
