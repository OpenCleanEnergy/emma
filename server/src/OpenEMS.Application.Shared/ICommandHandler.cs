using MediatR;

namespace OpenEMS.Application.Shared;

public interface ICommandHandler<in TCommand> : IRequestHandler<TCommand>
    where TCommand : ICommand;
