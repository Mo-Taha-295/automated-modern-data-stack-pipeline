select

    b.booking_id,

    b.listing_id,

    l.host_id,

    b.booking_date,

    b.nights_booked,

    b.booking_amount,

    b.cleaning_fee,

    b.service_fee,

    b.booking_amount
    + b.cleaning_fee
    + b.service_fee
    as total_booking_amount,

    b.booking_status

from {{ ref('bronze_booking') }} b

left join {{ ref('dim_listings') }} l
       on b.listing_id = l.listing_id

