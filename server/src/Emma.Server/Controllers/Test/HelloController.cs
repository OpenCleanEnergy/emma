using Microsoft.AspNetCore.Mvc;

namespace Emma.Server.Controllers.Test;

[ApiController]
[Route("v1/[controller]")]
public class HelloController : ControllerBase
{
    [HttpGet("me")]
    public MeDto Me()
    {
        return new MeDto
        {
            Name = User.Identity?.Name,
            AuthenticationType = User.Identity?.AuthenticationType,
            Claims = User.Claims.ToDictionary(x => x.Type, x => x.Value),
        };
    }
}
