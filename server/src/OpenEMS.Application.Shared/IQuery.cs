using MediatR;

namespace OpenEMS.Application.Shared;

public interface IQuery<out TResponse> : IRequest<TResponse>;
