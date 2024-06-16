using System.Text.Json;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Emma.Integrations.Shelly.Events.Status;

namespace Emma.Integrations.Shelly.Events;

public class ShellyEventSerializer
{
    private readonly JsonSerializerOptions _deserializeOptions;

    public ShellyEventSerializer()
    {
        _deserializeOptions = new JsonSerializerOptions() { PropertyNameCaseInsensitive = true, };
    }

    public virtual ShellyEvent? Deserialize(string json)
    {
        var eventInfo = JsonSerializer.Deserialize<EventInfo>(json, _deserializeOptions);
        if (eventInfo is null)
        {
            return null;
        }

        return eventInfo.Event switch
        {
            ShellyEvents.StatusOnChange => Deserialize<ShellyStatusOnChangeEvent>(json),
            ShellyEvents.Settings => Deserialize<ShellySettingsEvent>(json),
            ShellyEvents.Online => Deserialize<ShellyOnlineEvent>(json),
            ShellyEvents.CommandResponse => Deserialize<ShellyCommandResponseEvent>(json),
            _
                => new UnknownShellyEvent
                {
                    Event = eventInfo.Event,
                    DeviceId = eventInfo.DeviceId,
                    Json = json
                }
        };
    }

    private TEvent? Deserialize<TEvent>(string json)
        where TEvent : ShellyEvent
    {
        return JsonSerializer.Deserialize<TEvent>(json, _deserializeOptions);
    }

    public sealed class EventInfo
    {
        public required string Event { get; init; }
        public required ShellyDeviceId DeviceId { get; init; }
    }
}
