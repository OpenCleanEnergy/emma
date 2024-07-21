using OpenEMS.Application.Shared;
using OpenEMS.Domain.Meters;

namespace OpenEMS.Application.Devices.Meters;

public class DeleteElectricityMeterCommand : ICommand
{
    public required ElectricityMeterId ElectricityMeterId { get; init; }

    public class Handler : ICommandHandler<DeleteElectricityMeterCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IElectricityMeterRepository _repository;

        public Handler(IUnitOfWork uow, IElectricityMeterRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(
            DeleteElectricityMeterCommand request,
            CancellationToken cancellationToken
        )
        {
            await _repository.Delete(request.ElectricityMeterId);
            await _uow.SaveChanges();
        }
    }
}
