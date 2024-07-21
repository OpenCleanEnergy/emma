using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Domain;

public interface IGrantedShellyDeviceRepository
{
    void AddMany(IEnumerable<GrantedShellyDevice> grantedShellyDevices);
    Task<IReadOnlyCollection<GrantedShellyDevice>> GetAll();
    Task RemoveBy(ShellyDeviceId deviceId);
}
