using Emma.Application.Shared;
using Emma.Application.Shared.Identity;
using Emma.Domain;
using Emma.Domain.Producers;

namespace Emma.Application.Devices.Producers;

public class AddProducerCommand : ICommand
{
    public required IntegrationIdentifier Integration { get; init; }
    public required DeviceName DeviceName { get; init; }

    public class Handler : ICommandHandler<AddProducerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IProducerRepository _repository;
        private readonly ICurrentUserReader _currentUser;

        public Handler(
            IUnitOfWork uow,
            IProducerRepository repository,
            ICurrentUserReader currentUser
        )
        {
            _uow = uow;
            _repository = repository;
            _currentUser = currentUser;
        }

        public async Task Handle(AddProducerCommand request, CancellationToken cancellationToken)
        {
            var producer = new Producer
            {
                Name = request.DeviceName,
                Integration = request.Integration,
                OwnedBy = _currentUser.GetUserIdOrThrow(),
            };

            _repository.Add(producer);
            await _uow.SaveChanges();
        }
    }
}
