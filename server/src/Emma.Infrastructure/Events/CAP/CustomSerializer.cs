using System.Text.Json;
using DotNetCore.CAP;
using DotNetCore.CAP.Messages;
using DotNetCore.CAP.Serialization;
using Emma.Domain.Events;
using Microsoft.Extensions.Options;

namespace Emma.Infrastructure.Events.CAP;

public class CustomSerializer : ISerializer
{
    private readonly JsonUtf8Serializer _serializer;
    private readonly Dictionary<EventKey, Type> _eventTypesByEventKey;

    public CustomSerializer(
        IOptions<CapOptions> capOptions,
        IEnumerable<EventHandlerDescriptor> descriptors
    )
    {
        _serializer = new JsonUtf8Serializer(capOptions);
        _eventTypesByEventKey = descriptors
            .Select(desc => desc.DomainEvent)
            .DistinctBy(domainEvent => domainEvent.EventKey)
            .ToDictionary(
                domainEvent => domainEvent.EventKey,
                domainEvent => domainEvent.GetType()
            );
    }

    public Message? Deserialize(string json) => _serializer.Deserialize(json);

    public object? Deserialize(object value, Type valueType)
    {
        if (!valueType.IsAssignableTo(typeof(IEvent)))
        {
            return _serializer.Deserialize(value, valueType);
        }

        if (value is not JsonElement element)
        {
            throw new NotSupportedException(
                $"'{nameof(value)}' is not of type {nameof(JsonElement)}."
            );
        }

        if (!element.TryGetProperty(nameof(IEvent.EventKey), out var eventKeyValue))
        {
            throw new NotSupportedException(
                $"'{nameof(value)}' does not have an {nameof(IEvent.EventKey)} property."
            );
        }

        if (!EventKey.TryFrom(eventKeyValue.GetString(), out var eventKey))
        {
            throw new NotSupportedException(
                $"'{nameof(value)}' does not have a valid {nameof(IEvent.EventKey)}."
            );
        }

        if (!_eventTypesByEventKey.TryGetValue(eventKey, out var eventType))
        {
            throw new NotSupportedException($"Unknown {nameof(IEvent.EventKey)} '{eventKey}'.");
        }

        return _serializer.Deserialize(value, eventType);
    }

    public async ValueTask<Message> DeserializeAsync(
        TransportMessage transportMessage,
        Type? valueType
    )
    {
        if (valueType is null || !valueType.IsAssignableTo(typeof(IEvent)))
        {
            return await _serializer.DeserializeAsync(transportMessage, valueType);
        }

        var name = transportMessage.GetName();
        if (!EventKey.TryFrom(name, out var eventKey))
        {
            throw new NotSupportedException(
                $"'{nameof(transportMessage)}.{nameof(transportMessage.GetName)}()' returned an invalid {nameof(IEvent.EventKey)}."
            );
        }

        if (!_eventTypesByEventKey.TryGetValue(eventKey, out var eventType))
        {
            throw new NotSupportedException($"Unknown {nameof(IEvent.EventKey)} '{eventKey}'.");
        }

        return await _serializer.DeserializeAsync(transportMessage, eventType);
    }

    public bool IsJsonType(object jsonObject) => _serializer.IsJsonType(jsonObject);

    public string Serialize(Message message) => _serializer.Serialize(message);

    public ValueTask<TransportMessage> SerializeAsync(Message message) =>
        _serializer.SerializeAsync(message);
}
