with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('customers') }}

),

renamed as (

    select
        
        --ids
        id as customer_id,
        
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name, 
        shipping_address_1,
        shipping_address_2,
        city,
        state,
        zip

    from source

)

select * from renamed