using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Integrations.Shared;
using OpenEMS.Integrations.Shelly.Commands;
using OpenEMS.Integrations.Shelly.Commands.Relay;
using OpenEMS.Integrations.Shelly.Domain;

namespace OpenEMS.Integrations.Shelly;

public class ShellySwitchConsumerIntegration : ISwitchConsumerIntegration
{
    private readonly ShellyCommandSender _sender;

    public ShellySwitchConsumerIntegration(ShellyCommandSender sender)
    {
        _sender = sender;
    }

    public IntegrationId IntegrationId => ShellyIntegrationDescriptor.Id;

    public async Task Switch(IntegrationIdentifier integrationIdentifier, SwitchStatus status)
    {
        if (integrationIdentifier.Integration != IntegrationId)
        {
            return;
        }

        var shellyDeviceId = IntegrationDeviceIdConverter.GetShellyDeviceId(
            integrationIdentifier.Device
        );
        var shellyChannelIndex = IntegrationDeviceIdConverter.GetShellyChannelIndex(
            integrationIdentifier.Device
        );

        var request = status switch
        {
            SwitchStatus.Off => ShellyRelayCommandRequest.Off(shellyDeviceId, shellyChannelIndex),
            SwitchStatus.On => ShellyRelayCommandRequest.On(shellyDeviceId, shellyChannelIndex),
            _ => throw Exceptions.NotImplemented(status)
        };

        await _sender.Send(shellyDeviceId, request);
    }
}
