using System.Diagnostics.CodeAnalysis;
using System.Reflection;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.Json.Serialization.Metadata;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;
using OpenEMS.Integrations.Shelly.Events.Status;

namespace OpenEMS.Integrations.Shelly.Events;

public class ShellyEventSerializer
{
    private readonly JsonSerializerOptions _deserializeOptions;

    public ShellyEventSerializer()
    {
        _deserializeOptions = new JsonSerializerOptions()
        {
            PropertyNameCaseInsensitive = true,
            TypeInfoResolver = new DefaultJsonTypeInfoResolver
            {
                Modifiers = { AddPrivateFieldsModifier },
            }
        };
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

    [SuppressMessage(
        "Major Code Smell",
        "S3011:Reflection should not be used to increase accessibility of classes, methods, or fields",
        Justification = "Required to deserialize gen 2 components"
    )]
    private static void AddPrivateFieldsModifier(JsonTypeInfo jsonTypeInfo)
    {
        if (jsonTypeInfo.Kind != JsonTypeInfoKind.Object)
        {
            return;
        }

        var fields = jsonTypeInfo
            .Type.GetFields(BindingFlags.Instance | BindingFlags.NonPublic)
            .Where(field => field.IsDefined(typeof(JsonPropertyNameAttribute), false));

        foreach (var field in fields)
        {
            var name = field.GetCustomAttribute<JsonPropertyNameAttribute>()!.Name;
            var jsonPropertyInfo = jsonTypeInfo.CreateJsonPropertyInfo(field.FieldType, name);
            jsonPropertyInfo.Get = field.GetValue;
            jsonPropertyInfo.Set = field.SetValue;
            jsonTypeInfo.Properties.Add(jsonPropertyInfo);
        }
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
