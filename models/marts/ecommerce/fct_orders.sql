{{
    config(
        materialized='table'
    )
}}

with orders as (
    
    select * from {{ ref('order_calculations') }}
    
),

order_items as (
    
    select * from {{ ref('aggregated_items') }}
    
),

joined as (
    
    select
        *
    from orders
    left join order_items using (order_id)
    
)

select * from joined