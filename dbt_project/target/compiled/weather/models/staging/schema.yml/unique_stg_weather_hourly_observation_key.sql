
    
    

with dbt_test__target as (

  select observation_key as unique_field
  from `weatherman-509317`.`weather_analytics`.`stg_weather_hourly`
  where observation_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


