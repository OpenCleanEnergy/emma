using Emma.Application.Shared;
using Emma.Domain;
using Emma.Integrations.Shared;
using Emma.Integrations.Shelly.Domain;

namespace Emma.Integrations.Shelly.Application;

public class AddableDevicesQuery : IQuery<AddableShellyDeviceDto[]>
{
    public required DeviceCategory DeviceCategory { get; init; }

    public class Handler : IQueryHandler<AddableDevicesQuery, AddableShellyDeviceDto[]>
    {
        private readonly IGrantedShellyDeviceRepository _repository;
        private readonly IExistingDevicesReader _existingDevices;

        public Handler(
            IGrantedShellyDeviceRepository repository,
            IExistingDevicesReader existingDevices
        )
        {
            _repository = repository;
            _existingDevices = existingDevices;
        }

        public async Task<AddableShellyDeviceDto[]> Handle(
            AddableDevicesQuery request,
            CancellationToken cancellationToken
        )
        {
            var grantedDevices = await _repository.GetAll();

            var existingDevices = await _existingDevices.GetExistingDevicesIdentifier();

            var addableDevices = grantedDevices
                .Where(grantedDevice => grantedDevice.Supports(request.DeviceCategory))
                .Select(grantedDevice => new AddableShellyDeviceDto
                {
                    DeviceId = IntegrationDeviceIdConverter.GetIntegrationDeviceId(
                        grantedDevice.DeviceId,
                        grantedDevice.Index
                    ),
                    DeviceName = grantedDevice.Name.ToDeviceName(),
                })
                .Where(device =>
                    !existingDevices.Any(existing => existing == GetIdentifier(device))
                )
                .ToArray();

            return addableDevices;
        }

        private static IntegrationIdentifier GetIdentifier(AddableShellyDeviceDto deviceDto) =>
            new(ShellyIntegrationDescriptor.Id, deviceDto.DeviceId);
    }
}
