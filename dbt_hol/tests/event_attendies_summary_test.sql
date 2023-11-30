-- Test: Confirm that the number of confirmed attendees is less than or equal to the total number of invited attendees
WITH test_results AS (
    SELECT
        event_id,
        num_confirmed_attendees,
        num_invited_attendees
    FROM {{ ref('event_attendies_summary') }}
)

SELECT *
FROM test_results
WHERE num_confirmed_attendees > num_invited_attendees
