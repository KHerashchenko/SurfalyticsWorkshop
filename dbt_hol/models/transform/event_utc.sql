{{
    config(
        materialized='incremental',
        on_schema_change='fail'
    )
}}

SELECT
    event_id,
    summary,
    calendar_list_id,
    updated,
    CONVERT_TIMEZONE(start_time_zone, 'UTC', start_date_time::timestamp_ntz) AS utc_start_date_time,
    CONVERT_TIMEZONE(end_time_zone, 'UTC', end_date_time::timestamp_ntz) AS utc_end_date_time,
    html_link,
    organizer_email,
    status,
    location,
    _fivetran_synced
FROM {{ ref('event') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses > to include records whose timestamp occurred since the last run of this model)
  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
