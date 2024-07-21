using OpenEMS.Application.Shared;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Application.Devices.Producers;

public class DeleteProducerCommand : ICommand
{
    public required ProducerId ProducerId { get; init; }

    public class Handler : ICommandHandler<DeleteProducerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IProducerRepository _repository;

        public Handler(IUnitOfWork uow, IProducerRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(DeleteProducerCommand request, CancellationToken cancellationToken)
        {
            await _repository.Delete(request.ProducerId);
            await _uow.SaveChanges();
        }
    }
}
