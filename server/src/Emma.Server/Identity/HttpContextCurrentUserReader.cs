using System.Security.Claims;
using Emma.Application.Shared.Identity;
using Emma.Domain;

namespace Emma.Server.Identity;

public class HttpContextCurrentUserReader : ICurrentUserReader
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public HttpContextCurrentUserReader(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public UserId? GetUserIdOrDefault()
    {
        var context = _httpContextAccessor.HttpContext;
        if (context is null)
        {
            return null;
        }

        var userIdClaim = context.User.Claims.FirstOrDefault(claim =>
            claim.Type == ClaimTypes.NameIdentifier
        );

        return userIdClaim is null ? null : UserId.From(userIdClaim.Value);
    }

    public UserId GetUserIdOrThrow()
    {
        var userId = GetUserIdOrDefault();
        return userId ?? throw new InvalidOperationException("Unable to read user id.");
    }
}
