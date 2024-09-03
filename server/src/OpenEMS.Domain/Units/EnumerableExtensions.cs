namespace OpenEMS.Domain.Units;

public static class EnumerableExtensions
{
    public static Watt Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, Watt> selector)
    {
        return source.Select(selector).Sum();
    }

    public static Watt Sum(this IEnumerable<Watt> source)
    {
        var sum = source.Sum(watt => watt.Value);
        return Watt.From(sum);
    }

    public static WattHours Sum<TSource>(
        this IEnumerable<TSource> source,
        Func<TSource, WattHours> selector
    )
    {
        return source.Select(selector).Sum();
    }

    public static WattHours Sum(this IEnumerable<WattHours> source)
    {
        var sum = source.Sum(watt => watt.Value);
        return WattHours.From(sum);
    }
}
