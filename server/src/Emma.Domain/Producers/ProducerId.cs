using Vogen;

namespace Emma.Domain.Producers;

[ValueObject<Guid>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct ProducerId
{
    public static ProducerId NewId() => From(UuidFactory.NewSequentialGuid());

    private static Validation Validate(Guid input)
    {
        return input != Guid.Empty
            ? Validation.Ok
            : Validation.Invalid($"{nameof(ProducerId)} must not be empty.");
    }
}
