-- =========================================
-- STAGING: GA4 session_start events
-- Filters GA4 events to session_start only
-- =========================================

with events as (
  select
    parse_date('%Y%m%d', event_date) as event_date,  -- turn 'YYYYMMDD' into DATE
    event_name,
    user_pseudo_id,
    event_timestamp
  from {{ source('ga4_sample', 'events_sample') }}
  where _TABLE_SUFFIX between '20210101' and '20210131'
)

select
  event_date,
  user_pseudo_id,
  event_timestamp
from events
where event_name = 'session_start'
