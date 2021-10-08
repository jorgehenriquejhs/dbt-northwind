with
    source as (
        select
            shipper_id
            , company_name	
            , phone	

        from {{ source('erp_northwind_011021', 'public_shippers') }}
    )

select * from source