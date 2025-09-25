-- Monthly GA4 engagement (uses dim_date for month labels)
{{ config(materialized='table') }}

with daily as (
  select event_date, pageviews, sessions
  from {{ ref('fct_ga4_engagement_by_date') }}
),
d as (
  select date, year_month
  from {{ ref('dim_date') }}
)

select
  d.year_month,
  sum(daily.pageviews) as pageviews,
  sum(daily.sessions)  as sessions,
  safe_divide(sum(daily.pageviews), nullif(sum(daily.sessions), 0)) as pages_per_session
from daily
join d
  on daily.event_date = d.date              -- join fact date to dim_date.date
group by d.year_month
order by d.year_month
