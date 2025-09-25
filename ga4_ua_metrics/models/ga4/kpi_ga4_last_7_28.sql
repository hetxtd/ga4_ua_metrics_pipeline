{{ config(materialized='table') }}

with max_day as (
  select max(event_date) as max_date
  from {{ ref('fct_ga4_engagement_by_date') }}
),
ranges as (
  select
    max_date,
    date_sub(max_date, interval 6 day)  as d7_start,
    date_sub(max_date, interval 27 day) as d28_start
  from max_day
),
agg as (
  select
    'last_7_days' as window_label,
    sum(e.pageviews) as pageviews,
    sum(e.sessions)  as sessions
  from {{ ref('fct_ga4_engagement_by_date') }} e
  join ranges r on e.event_date between r.d7_start and r.max_date

  union all

  select
    'last_28_days' as window_label,
    sum(e.pageviews) as pageviews,
    sum(e.sessions)  as sessions
  from {{ ref('fct_ga4_engagement_by_date') }} e
  join ranges r on e.event_date between r.d28_start and r.max_date
)

select
  window_label,
  pageviews,
  sessions,
  safe_divide(pageviews, nullif(sessions, 0)) as pages_per_session
from agg
order by window_label
