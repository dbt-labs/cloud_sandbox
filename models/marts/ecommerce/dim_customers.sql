{{
    config(
        materialized='table'
    )
}}

with customers as (
    
    select * from {{ ref('stg_customers') }}
    
),

orders as (
    
    select * from {{ ref('aggregated_orders') }}
    
),

joined as (
    
    select
        *
    from customers
    left join orders using (customer_id)
    
)

select * from joined