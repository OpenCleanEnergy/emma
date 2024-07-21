using System.Diagnostics.CodeAnalysis;
using System.Linq.Expressions;
using System.Reflection;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Vogen;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.ValueConversion;

public class VogenValueObjectConverter<TValueObject, TValue> : ValueConverter<TValueObject, TValue>
    where TValue : notnull
{
    public VogenValueObjectConverter()
        : base(GenerateGetValue(), GenerateDeserializeValue()) { }

    private static Expression<Func<TValueObject, TValue>> GenerateGetValue()
    {
        var parameter = Expression.Parameter(typeof(TValueObject), "valueObject");
        var value = Expression.Property(
            parameter,
            nameof(ValueObjectConverterPlaceHolderValueObject.Value)
        );
        var lambda = Expression.Lambda<Func<TValueObject, TValue>>(value, parameter);
        return lambda;
    }

    [SuppressMessage(
        "Major Code Smell",
        "S3011:Reflection should not be used to increase accessibility of classes, methods, or fields",
        Justification = "Required to deserialize value object"
    )]
    private static Expression<Func<TValue, TValueObject>> GenerateDeserializeValue()
    {
        var parameter = Expression.Parameter(typeof(TValue), "value");
        var deserialize = Expression.Call(
            typeof(TValueObject).GetMethod(
                "__Deserialize",
                BindingFlags.Static | BindingFlags.NonPublic
            )!,
            parameter
        );
        var lambda = Expression.Lambda<Func<TValue, TValueObject>>(deserialize, parameter);
        return lambda;
    }
}

[ValueObject(comparison: ComparisonGeneration.Omit, conversions: Conversions.None)]
[SuppressMessage(
    "StyleCop.CSharp.MaintainabilityRules",
    "SA1402:File may only contain a single type",
    Justification = "Just a placeholder value object to use `nameof`."
)]
internal sealed partial class ValueObjectConverterPlaceHolderValueObject
{
    private static Validation Validate(int input)
    {
        _ = input;
        return Validation.Invalid(
            "This is just a placeholder value object. It should not be used."
        );
    }
}
