using System.Reflection;

namespace Emma.Server;

public static class ServiceInfo
{
    private static readonly Lazy<string> _lazyVersion = new(GetVersion);

    public static string Name => "emma-server";
    public static string Version => _lazyVersion.Value;

    private static string GetVersion()
    {
        var assembly = typeof(ServiceInfo).Assembly;
        var version = assembly
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
            ?.InformationalVersion;
        return version ?? "0.0.0";
    }
}
