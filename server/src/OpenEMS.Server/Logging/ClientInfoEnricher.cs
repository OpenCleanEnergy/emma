using Serilog.Core;
using Serilog.Events;

namespace OpenEMS.Server.Logging;

public class ClientInfoEnricher : ILogEventEnricher
{
    private readonly HttpContextAccessor _httpContextAccessor = new();

    public void Enrich(LogEvent logEvent, ILogEventPropertyFactory propertyFactory)
    {
        var httpContext = _httpContextAccessor.HttpContext;
        if (httpContext is null)
        {
            return;
        }

        var userAgent = GetValueOrDefault("User-Agent", httpContext.Request.Headers);
        if (userAgent is null)
        {
            return;
        }

        var clientInfo = new Dictionary<string, string?>()
        {
            ["UserAgent"] = userAgent,
            ["Version"] = GetValueOrDefault("OCE-Client-Version", httpContext.Request.Headers),
            ["Platform"] = GetValueOrDefault("OCE-Client-Platform", httpContext.Request.Headers),
        };

        var clientProperty = propertyFactory.CreateProperty("Client", clientInfo);
        logEvent.AddPropertyIfAbsent(clientProperty);
    }

    private static string? GetValueOrDefault(string key, IHeaderDictionary headers)
    {
        var values = headers[key];
        return values.Count == 0 ? null : values[0];
    }
}
