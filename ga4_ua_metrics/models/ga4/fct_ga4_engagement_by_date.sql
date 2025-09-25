-- =========================================
-- FACT: GA4 engagement summary by date
-- Joins daily pageviews + daily sessions
-- =========================================

-- Optional: persist as a table (faster to query repeatedly)
{{ config(materialized='table') }}

with pv as (
  select
    event_date,
    pageviews
  from {{ ref('fct_ga4_pageviews_by_date') }}
),
ss as (
  select
    event_date,
    sessions
  from {{ ref('fct_ga4_sessions_by_date') }}
)

select
  coalesce(pv.event_date, ss.event_date) as event_date,
  coalesce(pv.pageviews, 0) as pageviews,
  coalesce(ss.sessions, 0) as sessions,
  SAFE_DIVIDE(coalesce(pv.pageviews, 0), coalesce(ss.sessions, 0)) as pages_per_session
from pv
full outer join ss
  on pv.event_date = ss.event_date
order by event_date
