namespace Emma.Application.Devices;

public class DevicesDto
{
    public required IReadOnlyList<SwitchConsumerDto> SwitchConsumers { get; init; }
    public required IReadOnlyList<ProducerDto> Producers { get; init; }
    public required IReadOnlyList<ElectricityMeterDto> ElectricityMeters { get; init; }
}
