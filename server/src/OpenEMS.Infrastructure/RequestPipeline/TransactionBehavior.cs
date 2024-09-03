using DotNetCore.CAP;
using MediatR;
using Microsoft.EntityFrameworkCore;
using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.RequestPipeline;

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
