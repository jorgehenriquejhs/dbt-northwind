with
    customers as (
        select *
        from {{ ref('dim_customers') }}
    )
    , employees as (
        select *
        from {{ ref('dim_employees') }}
    )
    , products as (
        select *
        from {{ ref('dim_products') }}
    )
    , shippers as (
        select *
        from {{ ref('dim_shippers') }}
    )
    , suppliers as (
        select *
        from {{ ref('dim_suppliers') }}
    )
    , orders_with_sk as (
        select
            orders.order_id	
            , customers.customer_sk as customer_fk
            , employees.employee_sk as employee_fk
            , shippers.shipper_sk as shipper_fk	
            , orders.ship_region
            , orders.shipped_date
            , orders.ship_country
            , orders.ship_name	
            , orders.order_date
            , orders.ship_postal_code
            , orders.ship_city
            , orders.freight
            , orders.required_date				
            , orders.ship_address
        from {{ ref('stg_orders') }} orders
        left join employees on orders.employee_id = employees.employee_id
        left join customers on orders.customer_id = customers.customer_id
        left join shippers on orders.shipper_id = shippers.shipper_id
    )
    , order_details_with_sk as (
        select
            order_details.order_id	
            , products.product_sk as product_fk	
            , order_details.unit_price	
            , order_details.quantity	
            , order_details.discount
        from {{ ref('stg_order_details') }} order_details
        left join products on order_details.product_id = products.product_id
    )
    , final as (
        select
            order_details_with_sk.order_id	
            , orders_with_sk.customer_fk
            , orders_with_sk.employee_fk
            , orders_with_sk.shipper_fk	
            , orders_with_sk.ship_region
            , orders_with_sk.shipped_date
            , orders_with_sk.ship_country
            , orders_with_sk.ship_name	
            , orders_with_sk.order_date
            , orders_with_sk.ship_postal_code
            , orders_with_sk.ship_city
            , orders_with_sk.freight
            , orders_with_sk.required_date				
            , orders_with_sk.ship_address
            , order_details_with_sk.product_fk	
            , order_details_with_sk.unit_price	
            , order_details_with_sk.quantity	
            , order_details_with_sk.discount
        from orders_with_sk
        left join order_details_with_sk on orders_with_sk.order_id = order_details_with_sk.order_id
    )

select * from final