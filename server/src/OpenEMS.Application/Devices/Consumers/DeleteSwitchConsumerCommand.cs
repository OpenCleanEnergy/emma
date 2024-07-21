using OpenEMS.Application.Shared;
using OpenEMS.Domain.Consumers;

namespace OpenEMS.Application.Devices.Consumers;

public class DeleteSwitchConsumerCommand : ICommand
{
    public required SwitchConsumerId SwitchConsumerId { get; init; }

    public class Handler : ICommandHandler<DeleteSwitchConsumerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly ISwitchConsumerRepository _repository;

        public Handler(IUnitOfWork uow, ISwitchConsumerRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(
            DeleteSwitchConsumerCommand request,
            CancellationToken cancellationToken
        )
        {
            await _repository.Delete(request.SwitchConsumerId);
            await _uow.SaveChanges();
        }
    }
}
