with source as (

    select *
    from {{ ref('bronze_hosts') }}

),

cleaned as (

    select

        host_id,

        trim(host_name) as host_name,

        cast(host_since as date) as host_since,

        case
            when lower(is_superhost) in ('true','t','yes','y','1')
                then true
            else false
        end as is_superhost,

            response_rate/100 as response_rate,

         created_at ,

        dbt_bronze_loaded_at,

        row_number() over (
            partition by host_id
            order by created_at desc
        ) as rn

    from source

)

select

host_id,
host_name,
host_since,
is_superhost,
response_rate,
created_at,
dbt_bronze_loaded_at

from cleaned

where rn = 1


