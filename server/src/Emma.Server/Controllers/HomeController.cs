using Emma.Application.Home;
using Emma.Application.Shared.Identity;
using Emma.Server.LongPolling;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Emma.Server.Controllers;

[Route("v1/[controller]")]
public class HomeController : ControllerBase
{
    private readonly ISender _sender;

    private readonly ICurrentUserReader _currentUser;
    private readonly DevicesLongPolling _longPolling;

    public HomeController(
        ISender sender,
        ICurrentUserReader currentUser,
        DevicesLongPolling longPolling
    )
    {
        _sender = sender;
        _currentUser = currentUser;
        _longPolling = longPolling;
    }

    [HttpGet("", Name = nameof(HomeStatusQuery))]
    public async Task<HomeStatusDto> GetHomeStatus()
    {
        return await _sender.Send(new HomeStatusQuery());
    }

    [HttpGet("long-polling", Name = $"{nameof(HomeStatusQuery)}_LongPolling")]
    public async Task<HomeStatusDto> LongPollingAllDevices(CancellationToken cancellationToken)
    {
        var userId = _currentUser.GetUserIdOrThrow();
        await _longPolling.WaitForUpdates(userId, cancellationToken);
        return await _sender.Send(new HomeStatusQuery(), cancellationToken);
    }
}
