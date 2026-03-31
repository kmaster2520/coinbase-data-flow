{{ config(
    materialized = 'table',
    cluster_by = ['symbol']
) }}

SELECT
    symbol,
    COUNT(*) as totalTrades,
    MAX(tradeTime) as latestTradeTime,
    MIN(tradeTime) AS earliestTradeTime
FROM
    {{ ref('recent_coinbase_data_1d') }}
WHERE
    tradeTime >= current_timestamp() - INTERVAL '60 MINUTES'
GROUP BY
    symbol
