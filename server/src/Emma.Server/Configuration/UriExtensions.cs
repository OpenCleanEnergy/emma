namespace Emma.Server.Configuration;

public static class UriExtensions
{
    private const char Separator = '/';

    public static Uri Append(this Uri uri, params string[] segments)
    {
        IEnumerable<string> finalSegments = [uri.ToString().TrimEnd('/'), .. segments];
        return new(string.Join(Separator, finalSegments));
    }
}
