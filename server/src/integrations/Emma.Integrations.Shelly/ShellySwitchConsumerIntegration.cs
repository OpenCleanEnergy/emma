using Emma.Domain;
using Emma.Domain.Consumers;
using Emma.Integrations.Shared;
using Emma.Integrations.Shelly.Commands;
using Emma.Integrations.Shelly.Commands.Relay;
using Emma.Integrations.Shelly.Domain;

namespace Emma.Integrations.Shelly;

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
