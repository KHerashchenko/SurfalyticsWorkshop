select
    orders.order_id
    , orders.customer_id
    , customers.customer_city
    , customers.customer_state
    , orders.order_status
    , orders.order_date
    , orders_revenue.order_value as refunds_rev
from {{ref('orders')}}
left join {{ref('orders_revenue')}}
on orders.order_id = orders_revenue.order_id
left join {{ref('customers')}}
on orders.customer_id = customers.customer_id
where order_status in ('unavailable', 'canceled')
group by 1,2,3,4,5,6,7
