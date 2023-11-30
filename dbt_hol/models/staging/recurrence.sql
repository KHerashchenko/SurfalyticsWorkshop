SELECT
    event_id,
    recurrence,
    _fivetran_synced
FROM {{ source('pc_fivetran_db', 'recurrence') }}
