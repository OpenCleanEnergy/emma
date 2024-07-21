using Vogen;

namespace OpenEMS.Domain.Meters;

[ValueObject<Guid>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct ElectricityMeterId
{
    public static ElectricityMeterId NewId() => From(UuidFactory.NewSequentialGuid());

    private static Validation Validate(Guid input)
    {
        return input != Guid.Empty
            ? Validation.Ok
            : Validation.Invalid($"{nameof(ElectricityMeterId)} must not be empty.");
    }
}
