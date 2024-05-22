using Emma.Application.Shared;
using Emma.Application.Shared.Identity;
using Emma.Domain;
using Emma.Domain.Meters;

namespace Emma.Application.Devices.Meters;

public class AddElectricityMeterCommand : ICommand
{
    public required IntegrationIdentifier Integration { get; init; }
    public required DeviceName DeviceName { get; init; }

    public class Handler : ICommandHandler<AddElectricityMeterCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IElectricityMeterRepository _repository;
        private readonly ICurrentUserReader _currentUser;

        public Handler(
            IUnitOfWork uow,
            IElectricityMeterRepository repository,
            ICurrentUserReader currentUser
        )
        {
            _uow = uow;
            _repository = repository;
            _currentUser = currentUser;
        }

        public async Task Handle(
            AddElectricityMeterCommand request,
            CancellationToken cancellationToken
        )
        {
            var electricityMeter = new ElectricityMeter
            {
                Name = request.DeviceName,
                Integration = request.Integration,
                OwnedBy = _currentUser.GetUserIdOrThrow(),
            };

            _repository.Add(electricityMeter);
            await _uow.SaveChanges();
        }
    }
}
