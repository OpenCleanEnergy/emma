using System.Collections.Concurrent;
using System.Diagnostics.CodeAnalysis;
using System.Reflection;
using Serilog.Core;
using Serilog.Events;
using Vogen;

namespace Emma.Server.Logging;

public class ValueObjectDestructuringPolicy : IDestructuringPolicy
{
    private readonly ConcurrentDictionary<Type, Func<object, object?>> _valueAccessors = new();

    public bool TryDestructure(
        object value,
        ILogEventPropertyValueFactory propertyValueFactory,
        [NotNullWhen(true)] out LogEventPropertyValue? result
    )
    {
        var type = value.GetType();
        var isValueObject = type.IsDefined(typeof(ValueObjectAttribute));
        if (!isValueObject)
        {
            result = null;
            return false;
        }

        var valueAccessor = _valueAccessors.GetOrAdd(type, GetValueAccessor);
        result = new ScalarValue(valueAccessor(value));
        return true;
    }

    private static Func<object, object?> GetValueAccessor(Type type)
    {
        var valueProperty =
            type.GetProperty("Value")
            ?? throw new ArgumentException($"{type} does not have a 'Value' property.");
        return valueProperty.GetValue;
    }
}
