using Emma.Application.Shared;
using Emma.Domain.Consumers;

namespace Emma.Application.Devices.Consumers;

public class ManuallySwitchSwitchConsumerCommand : ICommand
{
    public required SwitchConsumerId SwitchConsumerId { get; init; }
    public required SwitchStatus Status { get; init; }

    public class Handler : ICommandHandler<ManuallySwitchSwitchConsumerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly ISwitchConsumerRepository _repository;

        public Handler(IUnitOfWork uow, ISwitchConsumerRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(
            ManuallySwitchSwitchConsumerCommand request,
            CancellationToken cancellationToken
        )
        {
            var switchConsumer = await _repository.FindBy(request.SwitchConsumerId);
            if (switchConsumer is null)
            {
                return;
            }

            switchConsumer.Switch(request.Status, SwitchActor.User);
            await _uow.SaveChanges();
        }
    }
}
