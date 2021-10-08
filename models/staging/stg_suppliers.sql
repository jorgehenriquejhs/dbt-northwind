with
    source as (
        select
            supplier_id
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
            , homepage

        from {{ source('erp_northwind_011021', 'public_suppliers') }}
    )

select * from source