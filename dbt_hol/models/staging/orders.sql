select
    order_id
    , customer_id
    , order_status
    , date(order_purchase_timestamp) as order_date
from {{ source('pc_fivetran_db', 'olist_orders_dataset') }}
group by 1,2,3,4
