-- =========================================
-- STAGING: GA4 users
-- Extracts distinct users from GA4 events
-- =========================================

with base as (
  select
    user_pseudo_id,
    parse_date('%Y%m%d', event_date) as event_date
  from {{ source('ga4_sample', 'events_sample') }}
  where _TABLE_SUFFIX between '20210101' and '20210131'
)

select
  user_pseudo_id,
  min(event_date) as first_seen_date,
  count(*) as total_events
from base
group by user_pseudo_id
