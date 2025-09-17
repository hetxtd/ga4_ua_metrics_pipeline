select
  extract(year from creation_date) as year,
  count(*) as question_count
from {{ ref('stg_stack_questions') }}
group by year
order by year
