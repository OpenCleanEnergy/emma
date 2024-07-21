using Vogen;

namespace OpenEMS.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct ShellyDeviceId;
