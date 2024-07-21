using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;

namespace OpenEMS.Application.Devices.Consumers;

public class AddSwitchConsumerCommand : ICommand
{
    public required IntegrationIdentifier Integration { get; init; }
    public required DeviceName DeviceName { get; init; }

    public class Handler : ICommandHandler<AddSwitchConsumerCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly ISwitchConsumerRepository _repository;
        private readonly ICurrentUserReader _currentUser;

        public Handler(
            IUnitOfWork uow,
            ISwitchConsumerRepository repository,
            ICurrentUserReader currentUser
        )
        {
            _uow = uow;
            _repository = repository;
            _currentUser = currentUser;
        }

        public async Task Handle(
            AddSwitchConsumerCommand request,
            CancellationToken cancellationToken
        )
        {
            var switchConsumer = new SwitchConsumer
            {
                Name = request.DeviceName,
                Integration = request.Integration,
                OwnedBy = _currentUser.GetUserIdOrThrow(),
            };

            _repository.Add(switchConsumer);
            await _uow.SaveChanges();
        }
    }
}
