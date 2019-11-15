with order_items as (

    select * from {{ ref('stg_order_items') }}
    
),

aggregated as (
    
    select 
        order_id,
        sum(quantity) as item_quantity 
    from order_items
    group by 1
    
)

select * from aggregated