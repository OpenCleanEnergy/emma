using System.Globalization;
using OpenEMS.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Domain;

public static class IntegrationDeviceIdConverter
{
    private const char Separator = '-';

    public static IntegrationDeviceId GetIntegrationDeviceId(
        ShellyDeviceId shellyDeviceId,
        ShellyChannelIndex index
    ) => IntegrationDeviceId.From($"{shellyDeviceId}{Separator}{index}");

    public static ShellyDeviceId GetShellyDeviceId(IntegrationDeviceId integrationDeviceId)
    {
        var (deviceId, _) = Split(integrationDeviceId);
        return ShellyDeviceId.From(deviceId);
    }

    public static ShellyChannelIndex GetShellyChannelIndex(IntegrationDeviceId integrationDeviceId)
    {
        var (_, channelIndex) = Split(integrationDeviceId);
        return ShellyChannelIndex.From(int.Parse(channelIndex, CultureInfo.InvariantCulture));
    }

    private static (string DeviceId, string ChannelIndex) Split(
        IntegrationDeviceId integrationDeviceId
    )
    {
        var index = integrationDeviceId.Value.LastIndexOf(Separator);
        var deviceId = integrationDeviceId.Value[..index];
        var channelIndex = integrationDeviceId.Value[(index + 1)..];
        return (deviceId, channelIndex);
    }
}
