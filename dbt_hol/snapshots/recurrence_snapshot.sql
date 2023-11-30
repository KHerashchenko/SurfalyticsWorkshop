{% snapshot recurrence_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='event_id',
      strategy='check',
      check_cols=['recurrence'],
    )
}}

select * from {{ source('pc_fivetran_db', 'recurrence') }}

{% endsnapshot %}
