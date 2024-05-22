using MediatR;

namespace Emma.Application.Shared;

public interface ICommandHandler<in TCommand> : IRequestHandler<TCommand>
    where TCommand : ICommand;
