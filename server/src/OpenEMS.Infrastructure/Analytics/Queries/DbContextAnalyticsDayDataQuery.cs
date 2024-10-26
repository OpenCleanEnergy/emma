using Microsoft.EntityFrameworkCore;
using Npgsql;
using OpenEMS.Analytics.Queries;
using OpenEMS.Analytics.Samples;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Persistence;

namespace OpenEMS.Infrastructure.Analytics.Queries;

public class DbContextAnalyticsDayDataQuery(
    AppDbContext context,
    ICurrentUserReader currentUserReader
) : IAnalyticsDayDataQuery
{
    private readonly AppDbContext _context = context;
    private readonly ICurrentUserReader _currentUserReader = currentUserReader;

    public async Task<DayData> QueryDayData(
        DateTimeOffset start,
        DateTimeOffset end,
        TimeSpan stride
    )
    {
        var userId = _currentUserReader.GetUserIdOrThrow();
        var parameters = new QueryParameters
        {
            User = new NpgsqlParameter("user_id", userId.Value),
            Start = new NpgsqlParameter("ts_start", start),
            End = new NpgsqlParameter("ts_end", end + stride),
            Stride = new NpgsqlParameter("date_bin_stride", stride),
        };

        var consumers = await ExecuteQuery(
            new()
            {
                TableName = GetTableName<SwitchConsumerSample>(),
                IdColumn = nameof(SwitchConsumerSample.SwitchConsumerId),
                PowerColumn = nameof(SwitchConsumerSample.CurrentPowerConsumption),
                Parameters = parameters,
            }
        );

        var producers = await ExecuteQuery(
            new()
            {
                TableName = GetTableName<ProducerSample>(),
                IdColumn = nameof(ProducerSample.ProducerId),
                PowerColumn = nameof(ProducerSample.CurrentPowerProduction),
                Parameters = parameters,
            }
        );

        var electricityMetersConsume = await ExecuteQuery(
            new()
            {
                TableName = GetTableName<ElectricityMeterSample>(),
                IdColumn = nameof(ElectricityMeterSample.ElectricityMeterId),
                PowerColumn = nameof(ElectricityMeterSample.CurrentPower),
                AdditionalFilter = $"""
                "{nameof(ElectricityMeterSample.CurrentPowerDirection)}"
                  IN ('{GridPowerDirection.None}', '{GridPowerDirection.Consume}')
                """,
                Parameters = parameters,
            }
        );

        var electricityMetersFeedIn = await ExecuteQuery(
            new()
            {
                Parameters = parameters,
                TableName = GetTableName<ElectricityMeterSample>(),
                IdColumn = nameof(ElectricityMeterSample.ElectricityMeterId),
                PowerColumn = nameof(ElectricityMeterSample.CurrentPower),
                AdditionalFilter = $"""
                "{nameof(ElectricityMeterSample.CurrentPowerDirection)}"
                  IN ('{GridPowerDirection.None}', '{GridPowerDirection.FeedIn}')
                """,
            }
        );

        return new DayData
        {
            Consumers = ToPowerDataPoints(consumers),
            Producers = ToPowerDataPoints(producers),
            ElectricityMetersConsume = ToPowerDataPoints(electricityMetersConsume),
            ElectricityMetersFeedIn = ToPowerDataPoints(electricityMetersFeedIn),
        };
    }

    private static PowerDataPoint[] ToPowerDataPoints(RawPowerDataPoint[] dataPoints)
    {
        return
        [
            .. from dataPoint in dataPoints
            select new PowerDataPoint(dataPoint.Timestamp, Watt.From(dataPoint.Power ?? 0)),
        ];
    }

    private static string GetSql(QueryArgs args)
    {
        var cols = new
        {
            DeviceId = args.IdColumn,
            Power = args.PowerColumn,
            OwnedBy = nameof(ISample.OwnedBy),
            Timestamp = nameof(ISample.Timestamp),
        };

        var at = new
        {
            User = "@" + args.Parameters.User.ParameterName,
            Start = "@" + args.Parameters.Start.ParameterName,
            End = "@" + args.Parameters.End.ParameterName,
            Stride = "@" + args.Parameters.Stride.ParameterName,
        };

        var additionalFilter = !string.IsNullOrWhiteSpace(args.AdditionalFilter)
            ? $"AND {args.AdditionalFilter}"
            : null;

        return $"""
            WITH
            cte_bin AS (
              -- create timestamp bins
              SELECT
                "{cols.DeviceId}" AS bin_device_id,
                date_bin({at.Stride}, "{cols.Timestamp}", {at.Start}) AS bin_timestamp,
                "{cols.Power}" AS bin_current_power
              FROM "{args.TableName}"
              WHERE
                "{cols.OwnedBy}" = {at.User}
                AND "{cols.Timestamp}" >= {at.Start}
                AND "{cols.Timestamp}" <= {at.End}
                AND "{cols.Power}" IS NOT NULL
                {additionalFilter}
            ),
            cte_avg AS (
              -- compute average per device and bin
              SELECT
                bin_device_id AS avg_device_id,
                bin_timestamp AS avg_timestamp,
                avg(bin_current_power) AS avg_current_power
              FROM cte_bin
              GROUP BY bin_device_id, bin_timestamp
            )
            -- sum up to data point
            SELECT
              avg_timestamp AS "{nameof(RawPowerDataPoint.Timestamp)}",
              sum(avg_current_power) AS "{nameof(RawPowerDataPoint.Power)}"
            FROM cte_avg
            GROUP BY avg_timestamp
            ORDER BY avg_timestamp ASC;
            """;
    }

    private async Task<RawPowerDataPoint[]> ExecuteQuery(QueryArgs args)
    {
        var sql = GetSql(args);
        return await _context
            .Database.SqlQueryRaw<RawPowerDataPoint>(sql, args.Parameters.ToArray())
            .ToArrayAsync();
    }

    private string GetTableName<TSample>()
        where TSample : ISample
    {
        var entityType = typeof(TSample);

        var entityTypeModel =
            _context.Model.FindEntityType(entityType)
            ?? throw new InvalidOperationException($"Entity type {entityType} not found in model.");

        return entityTypeModel.GetTableName()
            ?? throw new InvalidOperationException($"Entity type {entityType} has no table name.");
    }

    private sealed class QueryArgs
    {
        public required string TableName { get; init; }
        public required string IdColumn { get; init; }
        public required string PowerColumn { get; init; }
        public string? AdditionalFilter { get; init; }
        public required QueryParameters Parameters { get; init; }
    }

    private sealed class QueryParameters
    {
        public required NpgsqlParameter User { get; init; }
        public required NpgsqlParameter Start { get; init; }
        public required NpgsqlParameter End { get; init; }
        public required NpgsqlParameter Stride { get; init; }

        public object[] ToArray() => [User, Start, End, Stride];
    }

    private sealed record RawPowerDataPoint(DateTimeOffset Timestamp, double? Power);
}
