with
    source as (
        select
            order_id	
            , product_id	
            , unit_price	
            , quantity	
            , discount	
	
        from {{ source('erp_northwind_011021', 'public_order_details') }}
    )

select * from source