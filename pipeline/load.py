import dlt
import requests

CITIES = {
    "New York": (40.71, -74.01),
    "Trenton": (40.22, -74.76),
    "Austin": (30.27, -97.74),
    "San Diego": (32.72, -117.16),
}


@dlt.resource(
    name="weather_hourly",
    write_disposition="merge",       # re-runs upsert instead of duplicating
    primary_key=["city", "time"],
)
def weather_hourly():
    for city, (lat, lon) in CITIES.items():
        resp = requests.get(
            "https://api.open-meteo.com/v1/forecast",
            params={
                "latitude": lat,
                "longitude": lon,
                "hourly": "temperature_2m,precipitation,wind_speed_10m",
                "past_days": 2,      # small overlap window; merge handles dupes
                "forecast_days": 1,
                "timezone": "UTC",
            },
            timeout=30,
        )
        resp.raise_for_status()
        h = resp.json()["hourly"]
        for i, t in enumerate(h["time"]):
            yield {
                "city": city,
                "time": t,
                "temperature_c": h["temperature_2m"][i],
                "precipitation_mm": h["precipitation"][i],
                "wind_speed_kmh": h["wind_speed_10m"][i],
            }


if __name__ == "__main__":
    pipeline = dlt.pipeline(
        pipeline_name="weather",
        destination="duckdb",
        dataset_name="weather_raw",
    )
    print(pipeline.run(weather_hourly()))
