using Emma.Application.Shared;
using Emma.Domain;
using Emma.Integrations.Shared;

namespace Emma.Integrations.Development.Application;

public class AddableDevelopmentDevicesQuery : IQuery<AddableDevelopmentDeviceDto[]>
{
    public required DeviceCategory DeviceCategory { get; init; }

    public class Handler
        : IQueryHandler<AddableDevelopmentDevicesQuery, AddableDevelopmentDeviceDto[]>
    {
        private readonly IExistingDevicesReader _existingDevices;

        public Handler(IExistingDevicesReader existingDevices)
        {
            _existingDevices = existingDevices;
        }

        public async Task<AddableDevelopmentDeviceDto[]> Handle(
            AddableDevelopmentDevicesQuery request,
            CancellationToken cancellationToken
        )
        {
            var availableDevices = request.DeviceCategory switch
            {
                DeviceCategory.Consumer
                    => new[]
                    {
                        new AddableDevelopmentDeviceDto
                        {
                            DeviceId = IntegrationDeviceId.From("development-consumer-0"),
                            DeviceName = DeviceName.From("Waschmaschine")
                        },
                        new AddableDevelopmentDeviceDto
                        {
                            DeviceId = IntegrationDeviceId.From("development-consumer-1"),
                            DeviceName = DeviceName.From("Geschirrspüler")
                        }
                    },
                DeviceCategory.Producer
                    => new[]
                    {
                        new AddableDevelopmentDeviceDto
                        {
                            DeviceId = IntegrationDeviceId.From("development-producer-0"),
                            DeviceName = DeviceName.From("Solar Anlage")
                        },
                        new AddableDevelopmentDeviceDto
                        {
                            DeviceId = IntegrationDeviceId.From("development-producer-1"),
                            DeviceName = DeviceName.From("Windrad")
                        }
                    },
                DeviceCategory.ElectricityMeter
                    => new[]
                    {
                        new AddableDevelopmentDeviceDto
                        {
                            DeviceId = IntegrationDeviceId.From("development-meter-0"),
                            DeviceName = DeviceName.From("Stromzähler")
                        },
                    },
                _ => throw Exceptions.NotImplemented(request.DeviceCategory)
            };

            var existingDevices = await _existingDevices.GetExistingDevicesIdentifier();

            return availableDevices
                .Where(device =>
                    !existingDevices.Any(existing => existing == GetIdentifier(device))
                )
                .ToArray();
        }

        private static IntegrationIdentifier GetIdentifier(AddableDevelopmentDeviceDto deviceDto) =>
            new(DevelopmentIntegrationDescriptor.Id, deviceDto.DeviceId);
    }
}
