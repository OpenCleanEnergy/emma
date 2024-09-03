using OpenEMS.Domain;

namespace OpenEMS.Integrations.Development.Application;

public class AddableDevelopmentDeviceDto
{
    public required IntegrationDeviceId DeviceId { get; init; }
    public required DeviceName DeviceName { get; init; }
}
