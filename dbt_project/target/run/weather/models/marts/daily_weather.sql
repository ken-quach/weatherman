
  
    

    create or replace table `weatherman-509317`.`weather_analytics`.`daily_weather`
      
    
    

    
    OPTIONS()
    as (
      select
    city,
    date(observed_at) as observation_date,
    round(avg(temperature_c), 1) as avg_temp_c,
    max(temperature_c) as max_temp_c,
    min(temperature_c) as min_temp_c,
    round(sum(precipitation_mm), 1) as total_precip_mm
from `weatherman-509317`.`weather_analytics`.`stg_weather_hourly`
group by city, observation_date
    );
  