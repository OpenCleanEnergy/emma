using Emma.Application.Devices;
using Emma.Application.Devices.Consumers;
using Emma.Application.Devices.Meters;
using Emma.Application.Devices.Producers;
using Emma.Application.Shared.Identity;
using Emma.Server.LongPolling;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Emma.Server.Controllers;

[Route("v1/[controller]")]
public class DevicesController : ControllerBase
{
    private readonly ISender _sender;
    private readonly ICurrentUserReader _currentUser;
    private readonly DevicesLongPolling _longPolling;

    public DevicesController(
        ISender sender,
        ICurrentUserReader currentUser,
        DevicesLongPolling longPolling
    )
    {
        _sender = sender;
        _currentUser = currentUser;
        _longPolling = longPolling;
    }

    [HttpGet("", Name = nameof(DevicesQuery))]
    public async Task<DevicesDto> GetAllDevices()
    {
        return await _sender.Send(new DevicesQuery());
    }

    [HttpGet("long-polling", Name = $"{nameof(DevicesQuery)}_LongPolling")]
    public async Task<DevicesDto> LongPollingAllDevices(CancellationToken cancellationToken)
    {
        var userId = _currentUser.GetUserIdOrThrow();
        await _longPolling.WaitForUpdates(userId, cancellationToken);
        return await _sender.Send(new DevicesQuery(), cancellationToken);
    }

    [HttpPost("switch-consumers", Name = nameof(AddSwitchConsumerCommand))]
    public async Task AddSwitchConsumer([FromBody] AddSwitchConsumerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpDelete("switch-consumers", Name = nameof(DeleteSwitchConsumerCommand))]
    public async Task DeleteSwitchConsumer([FromBody] DeleteSwitchConsumerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPut("switch-consumers", Name = nameof(EditSwitchConsumerCommand))]
    public async Task EditSwitchConsumer([FromBody] EditSwitchConsumerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPut(
        "switch-consumers/manually-switch",
        Name = nameof(ManuallySwitchSwitchConsumerCommand)
    )]
    public async Task ManuallySwitchSwitchConsumer(
        [FromBody] ManuallySwitchSwitchConsumerCommand command
    )
    {
        await _sender.Send(command);
    }

    [HttpPost("producers", Name = nameof(AddProducerCommand))]
    public async Task AddProducer([FromBody] AddProducerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpDelete("producers", Name = nameof(DeleteProducerCommand))]
    public async Task DeleteProducer([FromBody] DeleteProducerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPut("producers", Name = nameof(EditProducerCommand))]
    public async Task EditProducer([FromBody] EditProducerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPost("electricity-meters", Name = nameof(AddElectricityMeterCommand))]
    public async Task AddElectricityMeter([FromBody] AddElectricityMeterCommand command)
    {
        await _sender.Send(command);
    }

    [HttpDelete("electricity-meters", Name = nameof(DeleteElectricityMeterCommand))]
    public async Task DeleteElectricityMeter([FromBody] DeleteElectricityMeterCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPut("electricity-meters", Name = nameof(EditElectricityMeterCommand))]
    public async Task EditElectricityMeter([FromBody] EditElectricityMeterCommand command)
    {
        await _sender.Send(command);
    }
}
