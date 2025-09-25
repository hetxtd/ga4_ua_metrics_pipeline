-- =========================================
-- DIMENSION: GA4 Users
-- Cleaned user dimension table
-- =========================================

select
  user_pseudo_id,
  first_seen_date,
  total_events
from {{ ref('stg_ga4_users') }}
