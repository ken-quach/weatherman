select
    concat(city, '|', cast(time as string)) as observation_key,
    city,
    cast(time as timestamp) as observed_at,
    temperature_c,
    precipitation_mm,
    wind_speed_kmh
from {{ source('weather_raw', 'weather_hourly') }}
