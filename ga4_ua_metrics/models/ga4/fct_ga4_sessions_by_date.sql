-- =========================================
-- FACT: GA4 sessions by date
-- Metric = count of session_start events per day
-- =========================================

{{ config(materialized='table') }}

select
  event_date,
  count(*) as sessions
from {{ ref('stg_ga4_sessions') }}
group by event_date
order by event_date
