{{config(
    materialized='incremental' , 
    unique_key='HOST_ID'
)}}
select * 
from {{source('airbnb_data', 'HOSTS')}}

{% if is_incremental() %}
  -- We use >= to ensure no data falling on the exact max timestamp boundary is missed
  where CREATED_AT >= (select max(CREATED_AT) from {{ this }})
{% endif %}