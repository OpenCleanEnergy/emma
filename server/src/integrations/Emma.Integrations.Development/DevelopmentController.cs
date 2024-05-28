using Emma.Integrations.Development.Application;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Emma.Integrations.Shelly;

[ApiController]
[Route("integrations/development/v1")]
public class DevelopmentController : ControllerBase
{
    private readonly ISender _sender;

    public DevelopmentController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("addable-devices", Name = nameof(AddableDevelopmentDevicesQuery))]
    public async Task<IReadOnlyList<AddableDevelopmentDeviceDto>> GetAddableDevices(
        AddableDevelopmentDevicesQuery query
    )
    {
        return await _sender.Send(query);
    }
}
