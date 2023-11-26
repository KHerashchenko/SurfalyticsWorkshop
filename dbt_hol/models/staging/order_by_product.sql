select
    order_id
    , order_item_id
    , product_id
    , price
from {{ source('pc_fivetran_db', 'olist_order_items_dataset') }}
group by 1,2,3,4
