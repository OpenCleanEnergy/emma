using System.Globalization;
using Emma.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Domain;

public static class IntegrationDeviceIdConverter
{
    private const char Separator = '-';

    public static IntegrationDeviceId GetIntegrationDeviceId(
        ShellyDeviceId shellyDeviceId,
        ShellyChannelIndex index
    ) => IntegrationDeviceId.From($"{shellyDeviceId}{Separator}{index}");

    public static ShellyDeviceId GetShellyDeviceId(IntegrationDeviceId integrationDeviceId)
    {
        var parts = Split(integrationDeviceId);
        return ShellyDeviceId.From(parts[0]);
    }

    public static ShellyChannelIndex GetShellyChannelIndex(IntegrationDeviceId integrationDeviceId)
    {
        var parts = Split(integrationDeviceId);
        return ShellyChannelIndex.From(int.Parse(parts[1], CultureInfo.InvariantCulture));
    }

    private static string[] Split(IntegrationDeviceId integrationDeviceId)
    {
        return integrationDeviceId.Value.Split(Separator);
    }
}
