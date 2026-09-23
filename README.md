# Weather ELT Pipeline

An automated ELT pipeline that extracts weather data from the Open-Meteo API, loads it into Google BigQuery, transforms the raw data using dbt.

## Why I Built This

I built this project to practice designing an end-to-end cloud data pipeline and gain hands-on experience with tools commonly used in modern data engineering.

Rather than simply pulling data from an API, I wanted to build a pipeline that separates ingestion, storage, transformation, testing, and orchestration into distinct components.

The project gave me practical experience working with API ingestion, cloud data warehousing, ELT architecture, dbt transformations, data quality testing, and automated workflows.

## Architecture

```text
Open-Meteo API
       │
       ▼
 Python + dlt
       │
       ▼
BigQuery Raw Layer
       │
       ▼
      dbt
       │
   ┌───┴────┐
   ▼        ▼
Staging    Mart
             │
             ▼
      Analytics-ready data

```

### Data Flow

1. Weather data is retrieved from the Open-Meteo API.
2. `dlt` handles schema inference and loads the API data into BigQuery.
3. Records are merged using city and timestamp to make repeated pipeline runs idempotent.
4. dbt transforms the raw data into cleaned staging models.
5. Mart models create analytics-ready datasets.
6. dbt tests validate the transformed data.

## Tech Stack

| Technology      | Purpose                               |
| --------------- | ------------------------------------- |
| Python          | Pipeline development                  |
| Open-Meteo API  | Weather data source                   |
| dlt             | Data ingestion and loading            |
| Google BigQuery | Cloud data warehouse                  |
| dbt             | SQL transformations and data testing  |
| Git/GitHub      | Version control                       |

## Project Structure

```text
weatherman/
├── .github/
│   └── workflows/       # Automated pipeline workflow
├── pipeline/            # Python ingestion pipeline
├── dbt_project/         # dbt transformations and tests
├── requirements.txt     # Python dependencies
├── .gitignore
└── README.md
```

## Key Engineering Concepts

This project demonstrates:

* ELT pipeline architecture
* REST API ingestion
* Cloud data warehousing
* Incremental/idempotent data loading
* Dimensional data transformation
* Data quality testing
* Environment and secret management
* Automated pipeline orchestration
* Version-controlled analytics engineering

## Running Locally

### 1. Clone the repository

```bash
git clone <repository-url>
cd weatherman
```

### 2. Create a virtual environment

```bash
python -m venv .venv
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Google Cloud authentication

Create a Google Cloud project and service account with the appropriate BigQuery permissions.

Set the project:

```bash
export GCP_PROJECT_ID="your-project-id"
```

Authenticate locally:

```bash
gcloud auth application-default login
```

### 5. Run ingestion

```bash
python pipeline/load.py
```

### 6. Run dbt

```bash
DBT_PROFILES_DIR=dbt_project dbt build --project-dir dbt_project
```



## What I Learned

This project helped me understand how the individual pieces of a data pipeline work together.

In particular, I gained hands-on experience separating raw ingestion from downstream transformations, designing repeatable data loads, managing cloud credentials securely, testing transformed data with dbt.

It also helped bridge the gap between working with data as an analyst and thinking about how reliable data infrastructure is designed and maintained.
