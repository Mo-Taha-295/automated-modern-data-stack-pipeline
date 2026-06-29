select

    fb.host_id,

    dh.host_name,
    dh.is_superhost,

    date_trunc('month', fb.booking_date) as booking_month,

    count(*) as total_bookings,

    sum(case
            when fb.booking_status = 'Completed'
            then 1
            else 0
        end) as completed_bookings,

    sum(case
            when fb.booking_status = 'Cancelled'
            then 1
            else 0
        end) as cancelled_bookings,

    sum(fb.booking_amount) as booking_revenue,

    sum(fb.cleaning_fee) as cleaning_revenue,

    sum(fb.service_fee) as service_revenue,

    sum(fb.total_booking_amount) as total_revenue,

    avg(fb.total_booking_amount) as avg_booking_value,

    sum(fb.nights_booked) as total_nights

from {{ ref('fact_bookings') }} fb

left join {{ ref('dim_hosts') }} dh
    on fb.host_id = dh.host_id

group by

    fb.host_id,
    dh.host_name,
    dh.is_superhost,
    date_trunc('month', fb.booking_date)