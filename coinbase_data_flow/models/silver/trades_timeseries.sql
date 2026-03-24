{{ config(
    materialized='incremental',
    unique_key = 'tradeId',
    incremental_strategy = 'merge',
    on_schema_change = 'sync_all_columns'
) }}

with ranked as (
    SELECT
        *,
        row_number() over (
            partition by tradeId, symbol
            order by tradeTime desc
        ) as rn
    FROM
        {{ ref('raw_coinbase_data') }}
    WHERE
        eventType = 'market_trades'
        and tradeTime >= current_timestamp() - INTERVAL 90 DAY
        and tradeTime >= '2026-03-17'
)

select
    side,
    symbol,
    price,
    quantity,
    tradeTime,
    tradeId
FROM
    ranked
WHERE
    rn = 1
