with source as (

select *

from {{ ref('bronze_booking') }}

),

cleaned as (

select

booking_id,

listing_id,

booking_date,

nights_booked,

booking_amount,
cleaning_fee,

service_fee,

case

when lower(trim(booking_status))
='completed'

then 'Completed'

when lower(trim(booking_status))
='cancelled'

then 'Cancelled'

else 'Pending'

end

as booking_status,

 created_at,

dbt_bronze_loaded_at,

row_number() over(

partition by booking_id

order by created_at desc

) rn

from source

)

select

booking_id,
listing_id,
booking_date,
nights_booked,
booking_amount,
cleaning_fee,
service_fee,
booking_status,
created_at,
dbt_bronze_loaded_at

from cleaned

where rn=1

