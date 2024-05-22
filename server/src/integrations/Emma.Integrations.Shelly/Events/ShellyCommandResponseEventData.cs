namespace Emma.Integrations.Shelly.Events;

public sealed record ShellyCommandResponseEventData(bool IsOk, string? Res);
