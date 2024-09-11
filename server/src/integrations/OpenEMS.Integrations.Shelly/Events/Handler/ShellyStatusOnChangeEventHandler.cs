using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Units;
using OpenEMS.Integrations.Shared;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;
using OpenEMS.Integrations.Shelly.Events.Status;

namespace OpenEMS.Integrations.Shelly.Events.Handler;

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

        if (status.EM.Count > 0)
        {
            await HandleEM(deviceId, status.EM);
        }

        if (status.EMData.Count > 0)
        {
            await HandleEMData(deviceId, status.EMData);
        }

        if (status.EM1.Count > 0)
        {
            await HandleEM1(deviceId, status.EM1);
        }

        if (status.EM1Data.Count > 0)
        {
            await HandleEM1Data(deviceId, status.EM1Data);
        }

        for (int i = 0; i < status.PM1.Count; i++)
        {
            await HandlePM1(deviceId, ShellyChannelIndex.From(i), status.PM1[i]);
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
        var power = meters.Sum(meter => meter.Power);
        var total = meters.Sum(meter => meter.Total);
        var totalReturned = meters.Sum(meter => meter.TotalReturned);

        await ReportElectricityMeter(
            deviceId,
            power,
            totalEnergyConsumption: total,
            totalEnergyFeedIn: totalReturned
        );
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

            if (switchComponent.ActivePower.HasValue)
            {
                switchConsumer.ReportCurrentPowerConsumption(switchComponent.ActivePower.Value);
            }

            if (switchComponent.ActiveEnergy is not null)
            {
                switchConsumer.ReportTotalEnergyConsumption(switchComponent.ActiveEnergy.Total);
            }

            return;
        }

        var producer = await _devicesRepository.FindProducer(integration);
        if (producer is not null)
        {
            if (switchComponent.ActivePower.HasValue)
            {
                producer.ReportCurrentPowerProduction(switchComponent.ActivePower.Value);
            }

            if (switchComponent.ReturnedActiveEnergy is not null)
            {
                producer.ReportTotalEnergyProduction(switchComponent.ReturnedActiveEnergy.Total);
            }
        }
    }

    private async Task HandleEM(
        ShellyDeviceId deviceId,
        IReadOnlyList<ShellyEMComponentStatus> meters
    )
    {
        var power = meters.Sum(meter => meter.TotalActivePower ?? Watt.Zero);
        await ReportElectricityMeter(deviceId, power, null, null);
    }

    private async Task HandleEMData(
        ShellyDeviceId deviceId,
        IReadOnlyList<ShellyEMDataComponentStatus> data
    )
    {
        var total = data.Sum(em => em.TotalActive);
        var totalReturned = data.Sum(em => em.TotalActiveReturned);
        await ReportElectricityMeter(
            deviceId,
            null,
            totalEnergyConsumption: total,
            totalEnergyFeedIn: totalReturned
        );
    }

    private async Task HandleEM1(
        ShellyDeviceId deviceId,
        IReadOnlyList<ShellyEM1ComponentStatus> meters
    )
    {
        var power = meters.Sum(meter => meter.ActivePower ?? Watt.Zero);
        await ReportElectricityMeter(deviceId, power, null, null);
    }

    private async Task HandleEM1Data(
        ShellyDeviceId deviceId,
        IReadOnlyList<ShellyEM1DataComponentStatus> data
    )
    {
        var total = data.Sum(em1 => em1.TotalActiveEnergy);
        var totalReturned = data.Sum(em => em.TotalActiveReturnedEnergy);
        await ReportElectricityMeter(
            deviceId,
            null,
            totalEnergyConsumption: total,
            totalEnergyFeedIn: totalReturned
        );
    }

    private async Task HandlePM1(
        ShellyDeviceId deviceId,
        ShellyChannelIndex index,
        ShellyPM1ComponentStatus pm1Component
    )
    {
        var integration = new IntegrationIdentifier(
            ShellyIntegrationDescriptor.Id,
            IntegrationDeviceIdConverter.GetIntegrationDeviceId(deviceId, index)
        );

        var switchConsumer = await _devicesRepository.FindSwitchConsumer(integration);
        if (switchConsumer is not null)
        {
            switchConsumer.ReportCurrentPowerConsumption(pm1Component.ActivePower);
            switchConsumer.ReportTotalEnergyConsumption(pm1Component.ActiveEnergy.Total);
            return;
        }

        var producer = await _devicesRepository.FindProducer(integration);
        if (producer is not null)
        {
            producer.ReportCurrentPowerProduction(pm1Component.ActivePower);
            producer.ReportTotalEnergyProduction(pm1Component.ReturnedActiveEnergy.Total);
        }
    }

    private async Task ReportElectricityMeter(
        ShellyDeviceId deviceId,
        Watt? currentPower,
        WattHours? totalEnergyConsumption,
        WattHours? totalEnergyFeedIn
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

        if (currentPower.HasValue)
        {
            var direction = currentPower.Value switch
            {
                var x when x > Watt.Zero => GridPowerDirection.Consume,
                var x when x < Watt.Zero => GridPowerDirection.FeedIn,
                _ => GridPowerDirection.None,
            };

            electricityMeter.ReportCurrentPower(currentPower.Value, direction);
        }

        if (totalEnergyConsumption.HasValue)
        {
            electricityMeter.ReportTotalEnergyConsumption(totalEnergyConsumption.Value);
        }

        if (totalEnergyFeedIn.HasValue)
        {
            electricityMeter.ReportTotalEnergyFeedIn(totalEnergyFeedIn.Value);
        }
    }
}
