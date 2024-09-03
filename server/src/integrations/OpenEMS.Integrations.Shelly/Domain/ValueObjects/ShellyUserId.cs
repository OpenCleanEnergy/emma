using Vogen;

namespace OpenEMS.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<int>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct ShellyUserId;
