using System.Diagnostics.CodeAnalysis;
using System.Linq.Expressions;
using System.Reflection;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace Emma.Infrastructure.Persistence.EntityFramework.ValueConversion;

public class VogenValueObjectComparer<TValueObject> : ValueComparer<TValueObject>
    where TValueObject : struct
{
    public VogenValueObjectComparer()
        : base(GetEqualsExpression(), GetGetHashCodeExpression()) { }

    /// <summary>
    /// Creates an expression that returns the hash code of the value object if it is initialized, otherwise 0.
    /// <code>
    /// if (valueObject._isInitialized)
    ///   return valueObject.GetHashCode();
    /// else
    ///   return 0;
    /// </code>
    /// </summary>
    private static Expression<Func<TValueObject, int>> GetGetHashCodeExpression()
    {
        var getHashCodeMethod = typeof(TValueObject).GetMethod(nameof(object.GetHashCode))!;

        var valueObject = Expression.Parameter(typeof(TValueObject), "valueObject");
        var condition = Expression.Condition(
            IsInitialized(valueObject),
            Expression.Call(valueObject, getHashCodeMethod),
            Expression.Constant(0)
        );

        var lambda = Expression.Lambda<Func<TValueObject, int>>(condition, valueObject);
        return lambda;
    }

    /// <summary>
    /// Creates an expression that compares two value objects for equality.
    /// <code>
    /// if (!a._isInitialized AND !b._isInitialized)
    ///   return true;
    /// else
    ///   return a.Equals(b);
    /// </code>
    /// </summary>
    private static Expression<Func<TValueObject, TValueObject, bool>> GetEqualsExpression()
    {
        var equalsMethod = typeof(TValueObject).GetMethod(
            nameof(object.Equals),
            [typeof(TValueObject)]
        )!;

        var a = Expression.Parameter(typeof(TValueObject), "a");
        var b = Expression.Parameter(typeof(TValueObject), "a");

        var aIsNotInitialized = Expression.Not(IsInitialized(a));
        var bIsNotInitialized = Expression.Not(IsInitialized(b));

        var condition = Expression.Condition(
            Expression.AndAlso(aIsNotInitialized, bIsNotInitialized),
            Expression.Constant(true),
            Expression.Call(a, equalsMethod, b)
        );

        var lambda = Expression.Lambda<Func<TValueObject, TValueObject, bool>>(condition, a, b);
        return lambda;
    }

    [SuppressMessage(
        "Major Code Smell",
        "S3011:Reflection should not be used to increase accessibility of classes, methods, or fields",
        Justification = "_isInitialized is private but we need to access it to check whether we can call GetHashCode."
    )]
    private static MemberExpression IsInitialized(Expression parameter)
    {
        return Expression.Field(
            parameter,
            typeof(TValueObject).GetField(
                "_isInitialized",
                BindingFlags.NonPublic | BindingFlags.Instance
            )!
        );
    }
}
