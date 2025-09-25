-- ========================================
-- DIMENSION TABLE: Users
-- ========================================

-- This table describes "users" (dimension = GA4-style 'user dimension').
-- It provides attributes we can join to facts.

select
    id as user_id,          -- primary key (unique user ID)
    display_name,           -- username shown on StackOverflow
    reputation,             -- reputation score (like a 'user quality' dimension)
    creation_date           -- when the user account was created
from {{ ref('stg_stack_users') }}
