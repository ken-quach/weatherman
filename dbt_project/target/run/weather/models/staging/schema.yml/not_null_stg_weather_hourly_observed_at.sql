
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select observed_at
from `weatherman-509317`.`weather_analytics`.`stg_weather_hourly`
where observed_at is null



  
  
      
    ) dbt_internal_test