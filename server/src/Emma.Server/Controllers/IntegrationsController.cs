using Emma.Application.Integrations;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Emma.Server.Controllers;

[Route("v1/[controller]")]
public class IntegrationsController : ControllerBase
{
    private readonly ISender _sender;

    public IntegrationsController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("", Name = nameof(IntegrationsQuery))]
    public async Task<IntegrationDescriptionDto[]> GetIntegrations(IntegrationsQuery query)
    {
        var integrations = await _sender.Send(query);
        return integrations;
    }
}
