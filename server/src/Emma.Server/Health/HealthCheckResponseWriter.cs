using System.Reflection;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Emma.Server.Health;

public static class HealthCheckResponseWriter
{
    private const string ContentType = "application/json; charset=utf-8";
    private static readonly JsonSerializerOptions _serializerOptions =
        new(JsonSerializerDefaults.Web)
        {
            WriteIndented = true,
            Converters = { new JsonStringEnumConverter() }
        };

    private static readonly Lazy<string> _lazyVersion = new(GetVersion);

    public static async Task WriteResponse(HttpContext context, HealthReport healthReport)
    {
        var version = _lazyVersion.Value;
        var dto = new HealthReportDto(version, healthReport.Status, healthReport.TotalDuration);

        context.Response.ContentType = ContentType;
        await context.Response.WriteAsJsonAsync(dto, _serializerOptions);
    }

    private static string GetVersion()
    {
        var assembly = typeof(HealthCheckResponseWriter).Assembly;
        var version = assembly
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
            ?.InformationalVersion;
        return version ?? "0.0.0";
    }
}
