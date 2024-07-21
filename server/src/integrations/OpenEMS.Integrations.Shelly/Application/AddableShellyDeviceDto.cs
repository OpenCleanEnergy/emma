using OpenEMS.Domain;

namespace OpenEMS.Integrations.Shelly.Application;

public class AddableShellyDeviceDto
{
    public required IntegrationDeviceId DeviceId { get; init; }
    public required DeviceName DeviceName { get; init; }
}
