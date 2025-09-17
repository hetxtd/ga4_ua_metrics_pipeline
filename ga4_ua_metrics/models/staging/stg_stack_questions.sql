with questions as (
  select
    id,
    title,
    creation_date,
    owner_user_id
  from `bigquery-public-data.stackoverflow.posts_questions`
),
users as (
  select id
  from `bigquery-public-data.stackoverflow.users`
)

select q.*
from questions q
join users u
  on q.owner_user_id = u.id
-- optional: limit 100000  -- (you can add a limit if you want; the join keeps integrity)
