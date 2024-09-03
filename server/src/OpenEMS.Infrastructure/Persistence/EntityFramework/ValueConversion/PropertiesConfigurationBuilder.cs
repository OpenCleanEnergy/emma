using System.Reflection;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Vogen;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.ValueConversion;

public static class PropertiesConfigurationBuilder
{
    public static PropertiesConfigurationBuilder<TProperty> HaveVogenValueObjectConversion<TProperty>(
        this PropertiesConfigurationBuilder<TProperty> propertiesConfigurationBuilder
    )
        where TProperty : struct
    {
        if (!typeof(TProperty).IsDefined(typeof(ValueObjectAttribute)))
        {
            throw new InvalidOperationException(
                $"The type {typeof(TProperty).Name} must be marked with the {nameof(ValueObjectAttribute)}."
            );
        }

        var valueProperty = typeof(TProperty).GetProperty(
            nameof(ValueObjectConverterPlaceHolderValueObject.Value)
        )!;
        var underlyingType = valueProperty.PropertyType;

        var converterType = typeof(VogenValueObjectConverter<,>).MakeGenericType(
            typeof(TProperty),
            underlyingType
        );
        var comparerType = typeof(VogenValueObjectComparer<TProperty>);
        return propertiesConfigurationBuilder.HaveConversion(converterType, comparerType);
    }
}
