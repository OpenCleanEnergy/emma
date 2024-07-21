using OpenEMS.Application.Shared;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Application.Devices;

public class DevicesQuery : IQuery<DevicesDto>
{
    public class Handler : IQueryHandler<DevicesQuery, DevicesDto>
    {
        private readonly ISwitchConsumerRepository _switchConsumers;
        private readonly IProducerRepository _producers;

        private readonly IElectricityMeterRepository _electricityMeters;

        public Handler(
            ISwitchConsumerRepository switchConsumers,
            IProducerRepository producers,
            IElectricityMeterRepository electricityMeters
        )
        {
            _switchConsumers = switchConsumers;
            _producers = producers;
            _electricityMeters = electricityMeters;
        }

        public async Task<DevicesDto> Handle(
            DevicesQuery request,
            CancellationToken cancellationToken
        )
        {
            var switchConsumers = await _switchConsumers.GetAll();
            var producers = await _producers.GetAll();
            var electricityMeters = await _electricityMeters.GetAll();

            return new DevicesDto
            {
                SwitchConsumers = switchConsumers
                    .OrderBy(x => x.Name)
                    .Select(SwitchConsumerDto.From)
                    .ToArray(),
                Producers = producers.OrderBy(x => x.Name).Select(ProducerDto.From).ToArray(),
                ElectricityMeters = electricityMeters
                    .OrderBy(x => x.Name)
                    .Select(ElectricityMeterDto.From)
                    .ToArray()
            };
        }
    }
}
