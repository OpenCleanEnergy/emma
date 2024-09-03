using MediatR;
using Microsoft.AspNetCore.Mvc;
using OpenEMS.Integrations.Development.Application;

namespace OpenEMS.Integrations.Shelly;

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
        [FromQuery] AddableDevelopmentDevicesQuery query
    )
    {
        return await _sender.Send(query);
    }
}
