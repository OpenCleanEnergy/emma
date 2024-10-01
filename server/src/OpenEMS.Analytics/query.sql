-- Switch consumer
SELECT
  date_bin('15 minutes', ts, TIMESTAMP '2024-01-01') as "Timestamp",
  avg(sum_of_power) as "CurrentPower"
FROM
(
  SELECT
    "Timestamp" as ts,
    sum("CurrentPowerConsumption") as sum_of_power
  FROM "SwitchConsumerSamples"
  GROUP BY "Timestamp"
) s
GROUP BY "Timestamp"
ORDER BY "Timestamp";

WITH x AS (
  SELECT
    "Timestamp" as ts,
    sum("CurrentPowerConsumption") as current_power
  FROM "SwitchConsumerSamples"
  GROUP BY "Timestamp"
)
SELECT
  date_bin('15 minutes', ts, TIMESTAMP '2024-01-01') as "Timestamp",
  avg(current_power) as "CurrentPower"
FROM x
GROUP BY "Timestamp"
ORDER BY "Timestamp";

-- Producer
SELECT
  date_bin('15 minutes', ts, TIMESTAMP '2024-01-01') as "Timestamp",
  avg(sum_of_power) as "CurrentPower"
FROM
(
  SELECT
    "Timestamp" as ts,
    sum("CurrentPowerProduction") as sum_of_power
  FROM "ProducerSamples"
  GROUP BY "Timestamp"
) s
GROUP BY "Timestamp"
ORDER BY "Timestamp";

-- Energy meter consumption
SELECT
  date_bin('15 minutes', ts, TIMESTAMP '2024-01-01') as "Timestamp",
  avg(sum_of_power) as "CurrentPower"
FROM
(
  SELECT
    "Timestamp" as ts,
    sum("CurrentPower") as sum_of_power
  FROM "ElectricityMeterSamples"
  WHERE "CurrentPowerDirection" IN ('Consume', 'None')
  GROUP BY "Timestamp"
) s
GROUP BY "Timestamp"
ORDER BY "Timestamp";

-- Energy meter feed in
SELECT
  date_bin('15 minutes', ts, TIMESTAMP '2024-01-01') as "Timestamp",
  avg(sum_of_power) as "CurrentPower"
FROM
(
  SELECT
    "Timestamp" as ts,
    sum("CurrentPower") as sum_of_power
  FROM "ElectricityMeterSamples"
  WHERE "CurrentPowerDirection" IN ('FeedIn', 'None')
  GROUP BY "Timestamp"
) s
GROUP BY "Timestamp"
ORDER BY "Timestamp";

