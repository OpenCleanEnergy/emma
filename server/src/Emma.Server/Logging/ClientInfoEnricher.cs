using Serilog.Core;
using Serilog.Events;

namespace Emma.Server.Logging;

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

        var request = httpContext.Request;
        var name = GetValueOrDefault("oce-client-name", request.Headers);
        var version = GetValueOrDefault("oce-client-version", request.Headers);

        var clientInfo = new Dictionary<string, string>();
        if (name is not null)
        {
            clientInfo.Add("Name", name);
        }

        if (version is not null)
        {
            clientInfo.Add("Version", version);
        }

        if (clientInfo.Count == 0)
        {
            return;
        }

        var clientProperty = propertyFactory.CreateProperty("Client", clientInfo);
        logEvent.AddPropertyIfAbsent(clientProperty);
    }

    private static string? GetValueOrDefault(string key, IHeaderDictionary headers)
    {
        var values = headers[key];
        return values.Count == 0 ? null : values[0];
    }
}
