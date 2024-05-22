using MediatR;

namespace Emma.Application.Shared;

public interface IQuery<out TResponse> : IRequest<TResponse>;
