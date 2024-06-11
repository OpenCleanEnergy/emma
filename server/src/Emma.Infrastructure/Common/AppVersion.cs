using System.Reflection;

namespace Emma.Infrastructure.Common;

public static class AppVersion
{
    private static readonly Lazy<string> _lazyVersion = new(GetVersion);

    public static string Version => _lazyVersion.Value;

    private static string GetVersion()
    {
        var assembly = typeof(AppVersion).Assembly;
        var version = assembly
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
            ?.InformationalVersion;
        return version ?? "0.0.0";
    }
}
