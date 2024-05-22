using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Domain;

public interface IGrantedShellyDeviceRepository
{
    void AddMany(IEnumerable<GrantedShellyDevice> grantedShellyDevices);
    Task<IReadOnlyCollection<GrantedShellyDevice>> GetAll();
    Task RemoveBy(ShellyDeviceId deviceId);
}
