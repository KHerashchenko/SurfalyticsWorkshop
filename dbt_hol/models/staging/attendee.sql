SELECT
    event_id,
    email,
    response_status,
    _fivetran_synced
FROM {{ source('pc_fivetran_db', 'attendee') }}
