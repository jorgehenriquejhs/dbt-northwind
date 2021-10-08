with
    source as (
        select
            order_id	
            , customer_id	
            , employee_id	
            , ship_region
            , shipped_date
            , ship_country
            , ship_name	
            , order_date

            , ship_postal_code
            , ship_city
            , freight
            , ship_via as shipper_id
            , required_date				
            , ship_address	
            	
        from {{ source('erp_northwind_011021', 'public_orders') }}
    )

select * from source