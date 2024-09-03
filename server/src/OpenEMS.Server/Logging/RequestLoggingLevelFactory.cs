using Serilog.Events;

namespace OpenEMS.Server.Logging;

public static class RequestLoggingLevelFactory
{
    public static LogEventLevel GetLevel(
        HttpContext context,
        double elapsedMilliseconds,
        Exception? exception
    )
    {
        _ = elapsedMilliseconds;

        if (exception is not null)
        {
            return LogEventLevel.Error;
        }

        return context.Response.StatusCode switch
        {
            >= 500 => LogEventLevel.Error,
            >= 400 => LogEventLevel.Warning,
            _ => LogEventLevel.Information
        };
    }
}
