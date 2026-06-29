select

    host_id,
    host_name,
    host_since,
    is_superhost,
    response_rate
from {{ ref('silver_hosts') }}