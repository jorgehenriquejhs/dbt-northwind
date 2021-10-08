with
    source as (
        select
            customer_id
            , company_name
            , contact_name
            , contact_title
            , address
            , city
            , region		
            , country
            , postal_code
            , phone
            , fax

        from {{ source('erp_northwind_011021', 'public_customers') }}
    )

select * from source