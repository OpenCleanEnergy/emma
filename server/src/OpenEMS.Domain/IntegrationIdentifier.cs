namespace OpenEMS.Domain;

/// <summary>
/// Example: IntegrationIdentifier("shelly", "f43394").
/// </summary>
public record IntegrationIdentifier(IntegrationId Integration, IntegrationDeviceId Device);
