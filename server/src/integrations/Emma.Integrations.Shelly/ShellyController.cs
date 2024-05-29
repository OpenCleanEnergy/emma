using Emma.Domain;
using Emma.Integrations.Shelly.Application;
using Emma.Integrations.Shelly.Callback;
using Emma.Integrations.Shelly.Callback.Trust;
using Emma.Integrations.Shelly.PermissionsGrant;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Emma.Integrations.Shelly;

[ApiController]
[Route("integrations/shelly/v1")]
public class ShellyController : ControllerBase
{
    private readonly ISender _sender;
    private readonly ShellyTrustTokenValidator _tokenValidator;

    public ShellyController(ISender sender, ShellyTrustTokenValidator tokenValidator)
    {
        _sender = sender;
        _tokenValidator = tokenValidator;
    }

    /// <summary>
    /// See https://shelly-api-docs.shelly.cloud/integrator-api/users.
    /// </summary>
    [AllowAnonymous]
    [HttpPost("callback")]
    [ApiExplorerSettings(IgnoreApi = true)]
    public async Task<IActionResult> CallbackAsync(
        [FromHeader(Name = "SCL-Trust")] string? token,
        [FromQuery] UserId user,
        [FromBody] ShellyCallbackDto callback
    )
    {
        if (!_tokenValidator.Validate(token))
        {
            return NotFound();
        }

        var request = new ShellyCallbackCommand { UserId = user, Callback = callback };
        await _sender.Send(request);
        return Ok();
    }

    [HttpGet("grant", Name = nameof(ShellyPermissionGrantUriQuery))]
    public async Task<ShellyPermissionGrantUriQuery.ShellyPermissionGrantUriResponse> GetPermissionGrantUri()
    {
        return await _sender.Send(new ShellyPermissionGrantUriQuery());
    }

    [HttpGet("addable-devices", Name = nameof(AddableShellyDevicesQuery))]
    public async Task<IReadOnlyList<AddableShellyDeviceDto>> GetAddableDevices(
        [FromQuery] AddableShellyDevicesQuery query
    )
    {
        return await _sender.Send(query);
    }
}
