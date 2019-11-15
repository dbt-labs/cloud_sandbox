with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('order_items') }}

),

renamed as (

    select
        
        --ids
        id as order_item_id,
        order_id,
        item_id,
        
        item_name,
        qty as quantity,
        price,
        qty * price as revenue,
        cost

    from source

)

select * from renamed