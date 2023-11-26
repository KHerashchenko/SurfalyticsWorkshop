select
    order_date
    , customer_state
    , customer_city
    , count(distinct order_id) as orders_vol
    , count(distinct customer_id) as customers_vol
    , sum(revenue) as total_revenue
from {{ref('tr_revenue_report')}}
group by 1,2,3
