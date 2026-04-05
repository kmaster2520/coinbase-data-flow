{{ config(
    materialized = 'table',
    cluster_by = ['symbol']
) }}

SELECT
    symbol,
    price,
    tradeTime
FROM
    {{ ref('trades_timeseries') }}
WHERE
    tradeTime >= current_timestamp() - INTERVAL '25 HOURS'
