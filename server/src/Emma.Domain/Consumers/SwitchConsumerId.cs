using Vogen;

namespace Emma.Domain.Consumers;

[ValueObject<Guid>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct SwitchConsumerId
{
    public static SwitchConsumerId NewId() => From(UuidFactory.NewSequentialGuid());

    private static Validation Validate(Guid input)
    {
        return input != Guid.Empty
            ? Validation.Ok
            : Validation.Invalid($"{nameof(SwitchConsumerId)} must not be empty.");
    }
}
