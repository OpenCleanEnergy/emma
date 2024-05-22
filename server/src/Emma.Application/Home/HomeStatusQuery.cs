using Emma.Application.Shared;
using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Producers;
using Emma.Domain.Units;

namespace Emma.Application.Home;

public class HomeStatusQuery : IQuery<HomeStatusDto>
{
    public class Handler : IQueryHandler<HomeStatusQuery, HomeStatusDto>
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

        public async Task<HomeStatusDto> Handle(
            HomeStatusQuery request,
            CancellationToken cancellationToken
        )
        {
            return new HomeStatusDto
            {
                GridStatus = await GetGridStatusDto(),
                ConsumerStatus = await GetConsumerStatusDto(),
                ProducerStatus = await GetProducerStatusDto(),
            };
        }

        private async Task<GridStatusDto> GetGridStatusDto()
        {
            var electricityMeters = await _electricityMeters.GetAll();

            if (electricityMeters.Count == 0)
            {
                return GridStatusDto.Unavailable();
            }

            var currentPowerConsumption = electricityMeters
                .Where(meter => meter.CurrentPowerDirection == GridPowerDirection.Consume)
                .Sum(meter => meter.CurrentPower);

            var currentPowerFeedIn = electricityMeters
                .Where(meter => meter.CurrentPowerDirection == GridPowerDirection.FeedIn)
                .Sum(meter => meter.CurrentPower);

            var currentPower = currentPowerConsumption - currentPowerFeedIn;

            var currentPowerDirection = currentPower switch
            {
                var x when x > Watt.Zero => GridPowerDirection.Consume,
                var x when x < Watt.Zero => GridPowerDirection.FeedIn,
                _ => GridPowerDirection.None,
            };

            return new GridStatusDto
            {
                CurrentPowerDirection = currentPowerDirection,
                CurrentPower = currentPower.Abs(),
                MaximumPowerConsumption = electricityMeters.Sum(meter =>
                    meter.MaximumPowerConsumption
                ),
                MaximumPowerFeedIn = electricityMeters.Sum((meter) => meter.MaximumPowerFeedIn),
            };
        }

        private async Task<ConsumerStatusDto> GetConsumerStatusDto()
        {
            var switchConsumers = await _switchConsumers.GetAll();

            if (switchConsumers.Count == 0)
            {
                return ConsumerStatusDto.Unavailable();
            }

            return new ConsumerStatusDto
            {
                CurrentPowerConsumption = switchConsumers.Aggregate(
                    Watt.Zero,
                    (result, consumer) => result + consumer.CurrentPowerConsumption
                ),
                MaximumPowerConsumption = switchConsumers.Aggregate(
                    Watt.Zero,
                    (result, consumer) => result + consumer.MaximumPowerConsumption
                )
            };
        }

        private async Task<ProducerStatusDto> GetProducerStatusDto()
        {
            var producers = await _producers.GetAll();

            if (producers.Count == 0)
            {
                return ProducerStatusDto.Unavailable();
            }

            return new ProducerStatusDto
            {
                CurrentPowerProduction = producers.Aggregate(
                    Watt.Zero,
                    (result, producer) => result + producer.CurrentPowerProduction
                ),
                MaximumPowerProduction = producers.Aggregate(
                    Watt.Zero,
                    (result, producer) => result + producer.MaximumPowerProduction
                ),
            };
        }
    }
}
