{% set window -%}
  
  over (
    partition by customer_id
    order by created_at rows between unbounded preceding and unbounded following)

{%- endset %}


with orders as (
    
    select * from {{ ref('stg_orders') }}
    
),

order_numbers as (

    select

        *,

        row_number() over (
            partition by customer_id 
            order by created_at) 
        as customer_order_number,
        
        case
            when customer_order_number = 1
                then 'new'
            else 'repeat'
        end as new_vs_repeat        

    from orders
    
),

calculations as (

    select

        *,
        
        min(cast(created_at as timestamp)) {{window}} as customer_first_order_date,
        
        lag(created_at) 
            over (
                partition by customer_id
                order by created_at
            ) as previous_completed_order

    from order_numbers

),

date_diffs as (

    select

        *,

        {{ dbt_utils.datediff(
                'first_order_date',
                'created_at',
                'month') }}
        as months_since_first_order

    from calculations
    
)

select * from date_diffs