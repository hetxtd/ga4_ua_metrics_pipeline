-- =========================================
-- FACT: GA4 pageviews by date
-- Metric = count of page_view rows per day
-- =========================================
{{ config(materialized='table') }}

select
  event_date,
  count(*) as pageviews
from {{ ref('stg_ga4_pageviews') }}   -- build on the clean staging slice
group by event_date
order by event_date
