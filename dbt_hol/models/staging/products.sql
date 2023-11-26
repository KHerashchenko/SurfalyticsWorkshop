select
    prod_port.product_id
    , prod_port.product_category_name as prod_name_br
    , prod_eng.product_category_name_english as prod_name_en
from {{ source('pc_fivetran_db', 'olist_products_dataset') }} prod_port
left join {{ source('pc_fivetran_db', 'product_category_name_translation') }} prod_eng
on prod_port.product_category_name = prod_eng.product_category_name
group by 1,2,3
