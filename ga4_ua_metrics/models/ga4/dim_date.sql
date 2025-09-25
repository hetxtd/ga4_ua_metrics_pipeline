-- =========================================
-- DIMENSION: Date (calendar table)
-- Purpose: a reusable date spine with handy attributes
-- Works in BigQuery using GENERATE_DATE_ARRAY
-- =========================================

-- Store physically (fast to join), and cluster by the key
{{ config(materialized='table', cluster_by=['date']) }}

-- STEP 1: define your date range.
-- Keep it small for the sample (Jan 2021), expand later as needed.
with params as (
  select
    date('2021-01-01') as start_date,
    date('2021-01-31') as end_date
),

-- STEP 2: generate one row per day in the range.
-- GENERATE_DATE_ARRAY makes an array [start_date, ..., end_date]
date_spine as (
  select
    day as date
  from params,
  unnest(generate_date_array(start_date, end_date)) as day
)

-- STEP 3: add calendar attributes.
select
  date,                                       -- primary key
  extract(year  from date)        as year,    -- 2021
  extract(quarter from date)      as quarter, -- 1..4
  extract(month from date)        as month,   -- 1..12
  format_date('%Y-%m', date)      as year_month, -- "2021-01"
  extract(isoweek from date)      as iso_week,   -- 1..53 (ISO week number)
  extract(dayofweek from date)    as day_of_week, -- 1=Sunday..7=Saturday
  format_date('%A', date)         as weekday_name, -- "Monday"
  format_date('%d', date)         as day_of_month, -- "01".."31"
  -- Flags for convenience
  case when extract(dayofweek from date) in (1,7) then true else false end as is_weekend
from date_spine
