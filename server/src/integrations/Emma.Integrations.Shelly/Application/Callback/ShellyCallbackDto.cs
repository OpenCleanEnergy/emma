using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Callback;

public class ShellyCallbackDto
{
    public required ShellyUserId UserId { get; init; }
    public required ShellyDeviceId DeviceId { get; init; }
    public required ShellyDeviceType DeviceType { get; init; }
    public required ShellyDeviceCode DeviceCode { get; init; }
    public required ShellyCallbackAction Action { get; init; }
    public required FullyQualifiedDomainName Host { get; init; }
    public required IReadOnlyList<ShellyDeviceName> Name { get; init; }
}
