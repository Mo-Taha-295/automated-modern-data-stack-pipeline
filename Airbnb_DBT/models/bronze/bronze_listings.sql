{{config(
    materialized='incremental',
incremental_strategy='append'
)}}

select * , 
current_timestamp() as dbt_bronze_loaded_at 
from {{source('airbnb_data', 'LISTINGS')}}


{% if is_incremental() %}
  where CREATED_AT > (select max(CREATED_AT) from {{ this }}) -- filtering for new records based on the CREATED_AT column cause we don't have a load_at column in the source table 'til now
{% endif %}


