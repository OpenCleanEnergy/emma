using MediatR;
using Microsoft.AspNetCore.Mvc;
using OpenEMS.Application.Devices;
using OpenEMS.Application.Devices.Consumers;
using OpenEMS.Application.Devices.Meters;
using OpenEMS.Application.Devices.Producers;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Server.LongPolling;

namespace OpenEMS.Server.Controllers;

[ApiController]
[Route("v1/[controller]")]
public class DevicesController(
    ISender sender,
    ICurrentUserReader currentUser,
    DevicesLongPolling longPolling
) : ControllerBase
{
    private readonly ISender _sender = sender;
    private readonly ICurrentUserReader _currentUser = currentUser;
    private readonly DevicesLongPolling _longPolling = longPolling;

    [HttpGet("", Name = nameof(DevicesQuery))]
    public async Task<DevicesDto> GetAllDevices()
    {
        return await _sender.Send(new DevicesQuery());
    }

    [HttpGet("long-polling", Name = $"{nameof(DevicesQuery)}_LongPolling")]
    public async Task<DevicesDto> LongPollingAllDevices(
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
        return await _sender.Send(new DevicesQuery(), cancellationToken);
    }

    [HttpPost("switch-consumers", Name = nameof(AddSwitchConsumerCommand))]
    public async Task AddSwitchConsumer([FromBody] AddSwitchConsumerCommand command)
    {
        await _sender.Send(command);
    }

    [HttpDelete(
        $"switch-consumers/{{{nameof(DeleteSwitchConsumerCommand.SwitchConsumerId)}}}",
        Name = nameof(DeleteSwitchConsumerCommand)
    )]
    public async Task DeleteSwitchConsumer([FromRoute] DeleteSwitchConsumerCommand command)
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

    [HttpDelete(
        $"producers/{{{nameof(DeleteProducerCommand.ProducerId)}}}",
        Name = nameof(DeleteProducerCommand)
    )]
    public async Task DeleteProducer([FromRoute] DeleteProducerCommand command)
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

    [HttpDelete(
        $"electricity-meters/{{{nameof(DeleteElectricityMeterCommand.ElectricityMeterId)}}}",
        Name = nameof(DeleteElectricityMeterCommand)
    )]
    public async Task DeleteElectricityMeter([FromRoute] DeleteElectricityMeterCommand command)
    {
        await _sender.Send(command);
    }

    [HttpPut("electricity-meters", Name = nameof(EditElectricityMeterCommand))]
    public async Task EditElectricityMeter([FromBody] EditElectricityMeterCommand command)
    {
        await _sender.Send(command);
    }
}
