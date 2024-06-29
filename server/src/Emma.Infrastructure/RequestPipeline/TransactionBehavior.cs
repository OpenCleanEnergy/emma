using DotNetCore.CAP;
using Emma.Application.Shared;
using Emma.Infrastructure.Persistence;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Emma.Infrastructure.RequestPipeline;

public class TransactionBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : notnull
{
    private readonly AppDbContext _dbContext;
    private readonly ICapPublisher _capPublisher;

    public TransactionBehavior(AppDbContext dbContext, ICapPublisher capPublisher)
    {
        _dbContext = dbContext;
        _capPublisher = capPublisher;
    }

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken
    )
    {
        var queryInterfaces = typeof(TRequest).FindInterfaces(
            (Type type, object? _) =>
            {
                return type.IsGenericType && type.GetGenericTypeDefinition() == typeof(IQuery<>);
            },
            null
        );

        if (queryInterfaces.Length > 0)
        {
            return await next();
        }

        var transaction = await _dbContext.Database.BeginTransactionAsync(
            _capPublisher,
            autoCommit: true,
            cancellationToken: cancellationToken
        );

        using (transaction)
        {
            return await next();
        }
    }
}
