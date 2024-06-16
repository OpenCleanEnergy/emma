using Emma.Application.Shared;
using Emma.Application.Shared.Events;
using Emma.Domain;
using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Units;
using Emma.Integrations.Shared;
using Emma.Integrations.Shelly.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Emma.Integrations.Shelly.Events.Status;

namespace Emma.Integrations.Shelly.Events.Handler;

public class ShellyStatusOnChangeEventHandler
    : IEventHandler<ShellyStatusOnChangeEvent, ShellyEventChannel>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IDevicesRepository _devicesRepository;

    public ShellyStatusOnChangeEventHandler(
        IUnitOfWork unitOfWork,
        IDevicesRepository devicesRepository
    )
    {
        _unitOfWork = unitOfWork;
        _devicesRepository = devicesRepository;
    }

    public async Task Handle(
        EventRequest<ShellyStatusOnChangeEvent, ShellyEventChannel> request,
        CancellationToken cancellationToken
    )
    {
        var deviceId = request.DomainEvent.DeviceId;
        var status = request.DomainEvent.Status;

        // Gen 1
        for (int i = 0; i < status.Relays.Count; i++)
        {
            await HandleRelay(deviceId, ShellyChannelIndex.From(i), status.Relays[i]);
        }

        for (int i = 0; i < status.Meters.Count; i++)
        {
            await HandleMeter(deviceId, ShellyChannelIndex.From(i), status.Meters[i]);
        }

        if (status.EMeters.Count > 0)
        {
            await HandleEMeters(deviceId, status.EMeters);
        }

        // Gen 2
        for (int i = 0; i < status.Switches.Count; i++)
        {
            await HandleSwitch(deviceId, ShellyChannelIndex.From(i), status.Switches[i]);
        }

        await _unitOfWork.SaveChanges();
    }

    private async Task HandleRelay(
        ShellyDeviceId shellyDeviceId,
        ShellyChannelIndex index,
        ShellyRelayStatus relay
    )
    {
        var integration = new IntegrationIdentifier(
            ShellyIntegrationDescriptor.Id,
            IntegrationDeviceIdConverter.GetIntegrationDeviceId(shellyDeviceId, index)
        );

        var switchConsumer = await _devicesRepository.FindSwitchConsumer(integration);
        switchConsumer?.Switch(
            relay.IsOn ? SwitchStatus.On : SwitchStatus.Off,
            SwitchActor.Integration
        );
    }

    private async Task HandleMeter(
        ShellyDeviceId deviceId,
        ShellyChannelIndex index,
        ShellyMeterStatus meter
    )
    {
        var integration = new IntegrationIdentifier(
            ShellyIntegrationDescriptor.Id,
            IntegrationDeviceIdConverter.GetIntegrationDeviceId(deviceId, index)
        );

        var switchConsumer = await _devicesRepository.FindSwitchConsumer(integration);
        if (switchConsumer is not null)
        {
            switchConsumer.ReportCurrentPowerConsumption(meter.Power);
            switchConsumer.ReportTotalEnergyConsumption(meter.Total.ToWattHours());
            return;
        }

        var producer = await _devicesRepository.FindProducer(integration);
        if (producer is not null)
        {
            producer.ReportCurrentPowerProduction(meter.Power);
            producer.ReportTotalEnergyProduction(meter.Total.ToWattHours());
        }
    }

    private async Task HandleEMeters(
        ShellyDeviceId deviceId,
        IReadOnlyList<ShellyEMeterStatus> meters
    )
    {
        var integration = new IntegrationIdentifier(
            ShellyIntegrationDescriptor.Id,
            IntegrationDeviceIdConverter.GetIntegrationDeviceId(
                deviceId,
                ShellyChannelIndex.From(0)
            )
        );

        var electricityMeter = await _devicesRepository.FindElectricityMeter(integration);
        if (electricityMeter is null)
        {
            return;
        }

        var power = meters.Sum(meter => meter.Power);
        var total = meters.Sum(meter => meter.Total);
        var totalReturned = meters.Sum(meter => meter.TotalReturned);

        var direction = power switch
        {
            var x when x > Watt.Zero => GridPowerDirection.Consume,
            var x when x < Watt.Zero => GridPowerDirection.FeedIn,
            _ => GridPowerDirection.None
        };

        electricityMeter.ReportCurrentPower(power, direction);

        electricityMeter.TotalEnergyConsumption = total;
        electricityMeter.TotalEnergyFeedIn = totalReturned;
    }

    private async Task HandleSwitch(
        ShellyDeviceId deviceId,
        ShellyChannelIndex index,
        ShellySwitchComponentStatus switchComponent
    )
    {
        var integration = new IntegrationIdentifier(
            ShellyIntegrationDescriptor.Id,
            IntegrationDeviceIdConverter.GetIntegrationDeviceId(deviceId, index)
        );

        var switchConsumer = await _devicesRepository.FindSwitchConsumer(integration);
        if (switchConsumer is not null)
        {
            switchConsumer.Switch(
                switchComponent.Output ? SwitchStatus.On : SwitchStatus.Off,
                SwitchActor.Integration
            );

            if (switchComponent.Power.HasValue)
            {
                switchConsumer.ReportCurrentPowerConsumption(switchComponent.Power.Value);
            }

            if (switchComponent.Energy is not null)
            {
                switchConsumer.ReportTotalEnergyConsumption(switchComponent.Energy.Total);
            }

            return;
        }

        var producer = await _devicesRepository.FindProducer(integration);
        if (producer is not null)
        {
            if (switchComponent.Power.HasValue)
            {
                producer.ReportCurrentPowerProduction(switchComponent.Power.Value);
            }

            if (switchComponent.ReturnedEnergy is not null)
            {
                producer.ReportTotalEnergyProduction(switchComponent.ReturnedEnergy.Total);
            }
        }
    }
}
