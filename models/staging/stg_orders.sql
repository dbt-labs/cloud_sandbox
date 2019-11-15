with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('orders') }}

),

renamed as (

    select
        
        --ids
        id as order_id,
        customer_id,
        
        amount,
        is_gift,
        
        --dates
        order_date as created_at

    from source

)

select * from renamed