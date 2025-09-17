-- ========================================
-- FACT TABLE: Number of questions per user
-- ========================================

-- Source = staging questions table (already cleaned + tested)
select
    owner_user_id as user_id,   -- rename for clarity
    count(*) as question_count  -- how many questions each user asked
from {{ ref('stg_stack_questions') }}
group by user_id
order by question_count desc
