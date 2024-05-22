using Emma.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Domain;

public class GrantedShellyDevice : IHasOwner
{
    public required ShellyDeviceId DeviceId { get; init; }
    public required ShellyDeviceType DeviceType { get; init; }
    public required ShellyDeviceCode DeviceCode { get; init; }
    public required FullyQualifiedDomainName Host { get; init; }
    public required ShellyChannelIndex Index { get; init; }
    public required ShellyDeviceName Name { get; init; }
    public required UserId OwnedBy { get; init; }

    public bool Supports(DeviceCategory deviceCategory)
    {
        return deviceCategory switch
        {
            DeviceCategory.Consumer => DeviceType == ShellyDeviceType.Relay,
            DeviceCategory.Producer => DeviceType == ShellyDeviceType.Relay,
            DeviceCategory.ElectricityMeter => DeviceType == ShellyDeviceType.EMeter,
            _ => false,
        };
    }
}
