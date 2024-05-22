using Vogen;

namespace Emma.Domain;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct UserId
{
    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid($"{nameof(UserId)} must not be null or empty or whitespace.")
            : Validation.Ok;
    }
}
