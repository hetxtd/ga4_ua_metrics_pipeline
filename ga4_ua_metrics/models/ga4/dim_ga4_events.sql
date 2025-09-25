-- =========================================
-- DIMENSION: GA4 Events
-- Purpose: one row per event_name with simple labels
-- Source: our cleaned staging model (not raw)
-- =========================================

-- Store physically for fast joins
{{ config(materialized='table') }}

with distinct_events as (
  -- Grab the unique list of event names we actually see in our window
  select distinct event_name
  from {{ ref('stg_ga4_events') }}
),

labeled as (
  -- Add human-friendly labels you can group by in reports
  select
    event_name,

    -- Bucket each event into a broad group for reporting
    case
      when event_name in ('page_view', 'scroll', 'user_engagement') then 'engagement'
      when event_name in ('session_start')                          then 'session'
      when event_name in ('view_item', 'add_to_cart', 'purchase')   then 'ecommerce'
      else 'other'
    end as event_group,

    -- Flag GA4 core events (handy filter)
    case
      when event_name in ('page_view','session_start','user_engagement') then true
      else false
    end as is_core_event
  from distinct_events
)

select
  event_name,       -- PK for this dim
  event_group,      -- your taxonomy label
  is_core_event     -- quick boolean for filtering
from labeled
order by event_name
