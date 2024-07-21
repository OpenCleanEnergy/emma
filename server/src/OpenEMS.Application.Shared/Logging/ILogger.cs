using System.Diagnostics.CodeAnalysis;

namespace OpenEMS.Application.Shared.Logging;

[SuppressMessage(
    "Major Code Smell",
    "S2326:Unused type parameters should be removed",
    Justification = "Used by implementation."
)]
public interface ILogger<TContext> : ILogger { }

public interface ILogger
{
    IDisposable BeginContext(params KeyValuePair<string, object?>[] properties);

    bool IsEnabled(LogLevel logLevel);

    void Log(
        LogLevel logLevel,
        Exception? exception,
        string messageTemplate,
        params object?[] args
    );

    void Debug(string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Debug, null, messageTemplate, args);
    }

    void Info(string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Info, null, messageTemplate, args);
    }

    void Warning(string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Warning, null, messageTemplate, args);
    }

    void Warning(Exception exception, string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Warning, exception, messageTemplate, args);
    }

    void Error(Exception exception, string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Error, exception, messageTemplate, args);
    }

    void Critical(Exception exception, string messageTemplate, params object?[] args)
    {
        Log(LogLevel.Critical, exception, messageTemplate, args);
    }
}
