using Emma.Application.Shared;
using Emma.Domain;
using Emma.Integrations.Shelly.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Callback;

public class ShellyCallbackCommand : ICommand
{
    public required UserId UserId { get; init; }
    public required ShellyCallbackDto Callback { get; init; }

    public class Handler : ICommandHandler<ShellyCallbackCommand>
    {
        private readonly IUnitOfWork _uow;

        private readonly IGrantedShellyDeviceRepository _repository;

        public Handler(IUnitOfWork uow, IGrantedShellyDeviceRepository repository)
        {
            _uow = uow;
            _repository = repository;
        }

        public async Task Handle(ShellyCallbackCommand request, CancellationToken cancellationToken)
        {
            switch (request.Callback.Action)
            {
                case ShellyCallbackAction.Add:
                    await HandleAdd(request);
                    break;
                case ShellyCallbackAction.Remove:
                    await HandleRemove(request);
                    break;
                default:
                    throw Exceptions.NotImplemented(request.Callback.Action);
            }

            await _uow.SaveChanges();
        }

        private async Task HandleAdd(ShellyCallbackCommand command)
        {
            var dto = command.Callback;
            var devices =
                from name in dto.Name.Select((value, index) => (Value: value, Index: index))
                select new GrantedShellyDevice
                {
                    DeviceId = dto.DeviceId,
                    DeviceType = dto.DeviceType,
                    DeviceCode = dto.DeviceCode,
                    Host = dto.Host,
                    Index = ShellyChannelIndex.From(name.Index),
                    Name = name.Value,
                    OwnedBy = command.UserId,
                };

            await _repository.RemoveBy(dto.DeviceId);
            _repository.AddMany(devices);
        }

        private async Task HandleRemove(ShellyCallbackCommand command)
        {
            await _repository.RemoveBy(command.Callback.DeviceId);
        }
    }
}
