using MediatR;

namespace Emma.Application.Shared;

[RequiresTransaction]
public interface ICommand : IRequest;
