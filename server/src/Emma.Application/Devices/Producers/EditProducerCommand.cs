using Emma.Application.Shared;
using Emma.Domain;
using Emma.Domain.Producers;

namespace Emma.Application.Devices.Producers;

public class EditProducerCommand : ICommand
{
    public required ProducerId ProducerId { get; init; }
    public required DeviceName Name { get; init; }

    public class Handler : ICommandHandler<EditProducerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IProducerRepository _repository;

        public Handler(IUnitOfWork uow, IProducerRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(EditProducerCommand request, CancellationToken cancellationToken)
        {
            var device = await _repository.FindBy(request.ProducerId);

            if (device is null)
            {
                return;
            }

            device.Name = request.Name;
            await _uow.SaveChanges();
        }
    }
}
