using Emma.Domain;

namespace Emma.Integrations.Shelly.Application;

public class AddableShellyDeviceDto
{
    public required IntegrationDeviceId DeviceId { get; init; }
    public required DeviceName DeviceName { get; init; }
}
