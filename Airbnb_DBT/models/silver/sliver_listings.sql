with source as (

    select *
    from {{ ref('bronze_listings') }}

),

cleaned as (

select

listing_id,

host_id,

initcap(trim(property_type))
    as property_type,

initcap(trim(room_type))
    as room_type,

initcap(trim(city))
    as city,

initcap(trim(country))
    as country,

cast(accommodates as integer)
    as accommodates,

cast(bedrooms as integer)
    as bedrooms,

cast(bathrooms as numeric(3,1))
    as bathrooms,

cast(price_per_night as numeric(10,2))
    as price_per_night,

cast(created_at as timestamp)
    as created_at,

dbt_bronze_loaded_at,

row_number() over(

partition by listing_id

order by created_at desc

) rn

from source

)

select

listing_id,
host_id,
property_type,
room_type,
city,
country,
accommodates,
bedrooms,
bathrooms,
price_per_night,
created_at,
dbt_bronze_loaded_at

from cleaned

where rn=1
