using System.Diagnostics;
using Emma.Application.Shared.Identity;
using Emma.Application.Shared.Logging;
using MediatR;

namespace Emma.Application.Common;

public class LoggingBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly ICurrentUserReader _currentUserReader;
    private readonly ILogger<TRequest> _logger;

    public LoggingBehavior(ILogger<TRequest> logger, ICurrentUserReader currentUserReader)
    {
        _logger = logger;
        _currentUserReader = currentUserReader;
    }

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken
    )
    {
        var requestId = Guid.NewGuid();
        var userId = _currentUserReader.GetUserIdOrDefault();

        var context = new KeyValuePair<string, object?>[]
        {
            KeyValuePair.Create<string, object?>("RequestId", requestId),
            KeyValuePair.Create<string, object?>("UserId", userId)
        };

        using (_logger.BeginContext(context))
        {
            return await HandleLogging(request, next);
        }
    }

    private static async Task<(TResponse Response, long ElapsedMilliseconds)> HandleStopwatch(
        RequestHandlerDelegate<TResponse> next
    )
    {
        var sw = Stopwatch.StartNew();
        var response = await next();
        var elapsedMilliseconds = sw.ElapsedMilliseconds;

        return (response, elapsedMilliseconds);
    }

    private async Task<TResponse> HandleLogging(
        TRequest request,
        RequestHandlerDelegate<TResponse> next
    )
    {
        try
        {
            var logLevel = _logger.IsEnabled(LogLevel.Debug) ? LogLevel.Debug : LogLevel.Info;

            _logger.Log(
                logLevel,
                null,
                "Handling {@Request}",
                logLevel == LogLevel.Debug ? request : typeof(TRequest).Name
            );

            var (response, elapsedMilliseconds) = await HandleStopwatch(next);

            _logger.Log(
                logLevel,
                null,
                "Handled {Request} with response {@Response} in {ElapsedMs} ms",
                typeof(TRequest).Name,
                logLevel == LogLevel.Debug ? response : typeof(TResponse).Name,
                elapsedMilliseconds
            );

            return response;
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Exception while handling {Request}.", typeof(TRequest).Name);
            throw;
        }
    }
}
