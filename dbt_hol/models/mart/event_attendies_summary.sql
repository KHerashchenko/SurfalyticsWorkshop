WITH event_data AS (
    SELECT
        e.event_id,
        e.summary,
        e.calendar_list_id,
        e.updated,
        e.utc_start_date_time,
        e.utc_end_date_time,
        e.html_link,
        e.organizer_email,
        e.status,
        e.location,
        a.email AS attendee_email,
        a.response_status,
        ROW_NUMBER() OVER (PARTITION BY e.event_id ORDER BY a._fivetran_synced DESC) AS row_num
    FROM {{ ref('event_utc') }} e
    LEFT JOIN {{ ref('attendee') }} a ON e.event_id = a.event_id
),

event_attendee_aggregates AS (
    SELECT
        event_id,
        COUNT(DISTINCT attendee_email) AS num_invited_attendees,
        COUNT(DISTINCT (case when response_status = 'accepted' then attendee_email end)) AS num_confirmed_attendees
    FROM event_data
    GROUP BY event_id
)

SELECT
    ed.event_id,
    ed.summary,
    ed.calendar_list_id,
    ed.updated,
    ed.utc_start_date_time,
    ed.utc_end_date_time,
    ed.html_link,
    ed.organizer_email,
    ed.status,
    ed.location,
    ed.attendee_email as last_invited_attendee_email,
    ed.response_status as last_response_status,
    ea.num_invited_attendees,
    ea.num_confirmed_attendees
FROM event_data ed
JOIN event_attendee_aggregates ea ON ed.event_id = ea.event_id
WHERE ed.row_num = 1
