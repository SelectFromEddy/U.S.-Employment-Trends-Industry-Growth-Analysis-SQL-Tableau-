UPDATE staging_table 
SET industry_name = LOWER(industry_name),
    series_id = LOWER(series_id),
    year = LOWER(year),
    month_name = LOWER(month_name),
    quarter = LOWER(quarter);