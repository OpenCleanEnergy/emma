using Emma.Application.Shared;
using Emma.Domain;
using Emma.Domain.Consumers;

namespace Emma.Application.Devices.Consumers;

public class EditSwitchConsumerCommand : ICommand
{
    public required SwitchConsumerId SwitchConsumerId { get; init; }
    public required DeviceName Name { get; init; }

    public class Handler : ICommandHandler<EditSwitchConsumerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly ISwitchConsumerRepository _repository;

        public Handler(IUnitOfWork uow, ISwitchConsumerRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(
            EditSwitchConsumerCommand request,
            CancellationToken cancellationToken
        )
        {
            var device = await _repository.FindBy(request.SwitchConsumerId);

            if (device is null)
            {
                return;
            }

            device.Name = request.Name;
            await _uow.SaveChanges();
        }
    }
}
