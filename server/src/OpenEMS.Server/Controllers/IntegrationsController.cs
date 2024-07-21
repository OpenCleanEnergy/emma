using MediatR;
using Microsoft.AspNetCore.Mvc;
using OpenEMS.Application.Integrations;

namespace OpenEMS.Server.Controllers;

[ApiController]
[Route("v1/[controller]")]
public class IntegrationsController : ControllerBase
{
    private readonly ISender _sender;

    public IntegrationsController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("", Name = nameof(IntegrationsQuery))]
    public async Task<IntegrationDescriptionDto[]> GetIntegrations(
        [FromQuery] IntegrationsQuery query
    )
    {
        var integrations = await _sender.Send(query);
        return integrations;
    }
}
