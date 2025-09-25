# GA4 Analytics Engineering Project

This project takes **Google Analytics 4 (GA4) data**, cleans it, and builds tables for analysis using **dbt** and **BigQuery**.

---

## What the project does
- Uses GA4 public dataset as the raw source
- Creates **staging models** to clean and prepare raw events
- Builds **fact tables** (metrics like pageviews, sessions, engagement)
- Builds **dimension tables** (user profiles, calendar dates)
- Produces **KPI table** for last-7 vs last-28 days
- Runs data quality tests (not_null, unique, relationships)

---

## Why it matters
- Demonstrates ability to transform raw GA4 data into clean, business-ready models
- Shows knowledge of modern data pipeline design (source → staging → marts → KPIs)
- Reflects the type of work expected from a data engineer in production


---

## How to run
1. Connect dbt to BigQuery
2. Run:  
   ```bash
   dbt run
   dbt test
   dbt docs generate && dbt docs serve
   ```
3. This will build models and open docs with a lineage graph

---

## Main models
- `stg_ga4_events` → cleaned raw events
- `fct_ga4_pageviews_by_date` → daily pageviews
- `fct_ga4_sessions_by_date` → daily sessions
- `fct_ga4_engagement_by_date` → sessions, pageviews, pages/session
- `dim_ga4_users` → user profile table
- `dim_date` → calendar table
- `kpi_ga4_last_7_28` → last 7 vs 28 days KPIs

---

## Testing & Quality
- `not_null` tests to check no important field is missing
- `unique` tests to avoid duplicate IDs
- `relationships` tests to link facts → dimensions

Run all tests with:
```bash
dbt test
```

---

## Future Enhancements
- Make models update daily (incremental)
- Add ecommerce revenue/conversion facts
- Automate runs with GitHub Actions or Airflow
