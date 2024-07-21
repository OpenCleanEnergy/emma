using OpenEMS.Domain;

namespace OpenEMS.Application.Shared.Identity;

public interface ICurrentUserReader
{
    UserId? GetUserIdOrDefault();
    UserId GetUserIdOrThrow();
}
