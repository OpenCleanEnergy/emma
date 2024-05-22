using Emma.Domain;

namespace Emma.Application.Shared.Identity;

public interface ICurrentUserReader
{
    UserId? GetUserIdOrDefault();
    UserId GetUserIdOrThrow();
}
