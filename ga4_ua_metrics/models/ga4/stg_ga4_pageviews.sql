-- =========================================
-- STAGING: GA4 page_view events
-- Reads from the declared GA4 source, filters to page_view
-- =========================================

with events as (
  select
    parse_date('%Y%m%d', event_date) as event_date,  -- string YYYYMMDD -> DATE
    event_name,
    user_pseudo_id,
    event_timestamp
  from {{ source('ga4_sample', 'events_sample') }}   -- use the source from sources.yml
  where _TABLE_SUFFIX between '20210101' and '20210131'  -- same training window
)

select
  event_date,
  user_pseudo_id,
  event_timestamp
from events
where event_name = 'page_view'
