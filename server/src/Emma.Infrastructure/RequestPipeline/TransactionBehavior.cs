using DotNetCore.CAP;
using Emma.Application.Shared;
using Emma.Application.Shared.Events;
using Emma.Infrastructure.Persistence;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure.RequestPipeline;

public class TransactionBehavior<TRequest, TResponse>(
    AppDbContext dbContext,
    ICapPublisher capPublisher
) : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly AppDbContext _dbContext = dbContext;
    private readonly ICapPublisher _capPublisher = capPublisher;

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken
    )
    {
        var requiresTransaction = request is ICommand or IEventRequest;

        if (!requiresTransaction)
        {
            return await next();
        }

        var transaction = await _dbContext.Database.BeginTransactionAsync(
            _capPublisher,
            cancellationToken: cancellationToken
        );

        await using (transaction)
        {
            var response = await next();
            await transaction.CommitAsync(cancellationToken);
            return response;
        }
    }
}
