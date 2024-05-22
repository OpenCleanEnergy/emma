using Emma.Application.Shared;
using Emma.Domain;
using Emma.Domain.Meters;

namespace Emma.Application.Devices.Meters;

public class EditElectricityMeterCommand : ICommand
{
    public required ElectricityMeterId ElectricityMeterId { get; init; }
    public required DeviceName Name { get; init; }

    public class Handler : ICommandHandler<EditElectricityMeterCommand>
    {
        private readonly IUnitOfWork _uow;
        private readonly IElectricityMeterRepository _repository;

        public Handler(IUnitOfWork uow, IElectricityMeterRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(
            EditElectricityMeterCommand request,
            CancellationToken cancellationToken
        )
        {
            var device = await _repository.FindBy(request.ElectricityMeterId);

            if (device is null)
            {
                return;
            }

            device.Name = request.Name;
            await _uow.SaveChanges();
        }
    }
}
