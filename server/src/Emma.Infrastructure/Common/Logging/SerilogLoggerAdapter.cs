using System.Diagnostics.CodeAnalysis;
using Emma.Application.Shared.Logging;
using Serilog.Context;
using Serilog.Core.Enrichers;
using Serilog.Events;

namespace Emma.Infrastructure.Common.Logging;

[SuppressMessage(
    "StyleCop.CSharp.MaintainabilityRules",
    "SA1402:File may only contain a single type",
    Justification = "Generic and non generic type may be in same file."
)]
public class SerilogLoggerAdapter<TContextT> : SerilogLoggerAdapter, ILogger<TContextT>
{
    public SerilogLoggerAdapter(Serilog.ILogger logger)
        : base(logger.ForContext<TContextT>()) { }
}

public class SerilogLoggerAdapter : ILogger
{
    private readonly Serilog.ILogger _logger;

    public SerilogLoggerAdapter(Serilog.ILogger logger)
    {
        _logger = logger;
    }

    [SuppressMessage(
        "Minor Code Smell",
        "S3220:Method calls should not resolve ambiguously to overloads with \"params\"",
        Justification = "No other overload available."
    )]
    public IDisposable BeginContext(params KeyValuePair<string, object?>[] properties)
    {
        return LogContext.Push(
            [.. properties.Select(prop => new PropertyEnricher(prop.Key, prop.Value))]
        );
    }

    public bool IsEnabled(LogLevel logLevel) => _logger.IsEnabled(ToLogEventLevel(logLevel));

    public void Log(
        LogLevel logLevel,
        Exception? exception,
        string messageTemplate,
        params object?[] args
    )
    {
        var logEventLevel = ToLogEventLevel(logLevel);
        _logger.Write(logEventLevel, exception, messageTemplate, args);
    }

    private static LogEventLevel ToLogEventLevel(LogLevel logLevel)
    {
        return logLevel switch
        {
            LogLevel.Debug => LogEventLevel.Debug,
            LogLevel.Info => LogEventLevel.Information,
            LogLevel.Warning => LogEventLevel.Warning,
            LogLevel.Error => LogEventLevel.Error,
            LogLevel.Critical => LogEventLevel.Fatal,
            _
                => throw new NotImplementedException(
                    $"{nameof(LogLevel)} {logLevel} is not implemented."
                ),
        };
    }
}
