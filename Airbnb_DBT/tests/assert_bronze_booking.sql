select 
    NIGHTS_BOOKED , BOOKING_AMOUNT
from {{ref ('bronze_booking')}}
where NIGHTS_BOOKED < 1 and BOOKING_AMOUNT < 0 