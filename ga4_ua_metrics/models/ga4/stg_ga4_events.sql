-- =========================================
-- STAGING: GA4 events (sample dataset)
-- Reads from public GA4 export: events_* tables
-- =========================================

-- We query a small date window to keep costs tiny while we learn.
-- You can widen/narrow the window by changing the BETWEEN values.

with base as (
  select
    parse_date('%Y%m%d', event_date) as event_date,
    event_name,
    user_pseudo_id,
    event_timestamp
  from {{ source('ga4_sample', 'events_sample') }}   -- <— use the declared source
  where _TABLE_SUFFIX between '20210101' and '20210131'
)
select
  event_date,
  event_name,
  user_pseudo_id,
  event_timestamp
from base

