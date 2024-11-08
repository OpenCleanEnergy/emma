using MediatR;
using Microsoft.AspNetCore.Mvc;
using OpenEMS.Application.Home;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Server.LongPolling;

namespace OpenEMS.Server.Controllers;

[ApiController]
[Route("v1/[controller]")]
public class HomeController(
    ISender sender,
    ICurrentUserReader currentUser,
    HomeLongPolling longPolling
) : ControllerBase
{
    private readonly ISender _sender = sender;

    private readonly ICurrentUserReader _currentUser = currentUser;
    private readonly HomeLongPolling _longPolling = longPolling;

    [HttpGet("", Name = nameof(HomeStatusQuery))]
    public async Task<HomeStatusDto> GetHomeStatus()
    {
        return await _sender.Send(new HomeStatusQuery());
    }

    [HttpGet("long-polling", Name = $"{nameof(HomeStatusQuery)}_LongPolling")]
    public async Task<HomeStatusDto> LongPollingAllDevices(
        [FromQuery] int session,
        CancellationToken cancellationToken
    )
    {
        var userId = _currentUser.GetUserIdOrThrow();
        await _longPolling.WaitForUpdates(
            userId,
            LongPollingSession.From(session),
            cancellationToken
        );
        return await _sender.Send(new HomeStatusQuery(), cancellationToken);
    }
}
