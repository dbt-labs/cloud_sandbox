with orders as (

    select * from {{ ref('order_calculations') }}
    
),

aggregated as (
    
    select 
        customer_id,
        min(created_at) as first_order_date,
        count(*) as lifetime_orders,
        sum(amount) as lifetime_revenue
    from orders
    group by 1
    
)

select * from aggregated