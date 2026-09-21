# Weather ELT Pipeline

Open-Meteo API → dlt → BigQuery → dbt, scheduled daily with GitHub Actions.

## Problem
(One paragraph: what this demonstrates and why.)

## Architecture
(Add a diagram here: API → dlt (merge on city+time) → weather_raw → dbt staging → mart → dashboard)

## Tech choices
- dlt: schema inference and idempotent merge loads
- BigQuery: free tier, marketable warehouse
- dbt: tested, versioned transformations
- GitHub Actions: zero-server orchestration

## Run it
1. Create a GCP project and service account (BigQuery Data Editor + Job User)
2. Add repo secrets: `GCP_PROJECT_ID`, `GCP_SA_KEY` (the JSON key)
3. Locally: `pip install -r requirements.txt`, `gcloud auth application-default login`,
   `export GCP_PROJECT_ID=...`, `python pipeline/load.py`, then
   `DBT_PROFILES_DIR=dbt_project dbt build --project-dir dbt_project`

## Dashboard
(Link to Tableau Public / Looker Studio)
