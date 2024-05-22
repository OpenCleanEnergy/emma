using System.Text.Json.Serialization;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Commands;

/// <summary>
/// https://shelly-api-docs.shelly.cloud/integrator-api/communication#commands.
/// </summary>
/// <typeparam name="TData">
/// The command request data.
/// E.g. <see cref="ShellyRelayCommandRequestData"/>.
/// </typeparam>
public abstract class ShellyCommandRequest
{
    [JsonPropertyName("event")]
    public string Event { get; } = "Shelly:CommandRequest";

    /// <summary>
    /// Gets the transaction identifier.
    /// </summary>
    [JsonPropertyName("trid")]
    public TransactionId TransactionId { get; } = TransactionId.Next();

    [JsonPropertyName("deviceId")]
    public required ShellyDeviceId DeviceId { get; init; }
}
