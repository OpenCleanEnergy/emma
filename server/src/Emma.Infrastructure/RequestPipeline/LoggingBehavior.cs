using System.Diagnostics;
using Emma.Application.Shared.Identity;
using Emma.Application.Shared.Logging;
using MediatR;

namespace Emma.Infrastructure.RequestPipeline;

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
            KeyValuePair.Create<string, object?>("RequestType", typeof(TRequest)),
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
            var (verbose, logLevel) = _logger.IsEnabled(LogLevel.Debug)
                ? (true, LogLevel.Debug)
                : (false, LogLevel.Info);

            _logger.Log(
                logLevel,
                null,
                "Handling {@Request}",
                verbose ? request : typeof(TRequest)
            );

            var (response, elapsedMilliseconds) = await HandleStopwatch(next);

            _logger.Log(
                logLevel,
                null,
                "Handled {Request} with response {@Response} in {ElapsedMs} ms",
                verbose ? request : typeof(TRequest),
                verbose ? response : typeof(TResponse),
                elapsedMilliseconds
            );

            return response;
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Exception while handling {@Request}.", request);
            throw;
        }
    }
}
