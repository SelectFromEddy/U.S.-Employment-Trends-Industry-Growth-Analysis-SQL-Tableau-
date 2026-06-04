

UPDATE staging_table
SET industry_name = LTRIM(RTRIM(industry_name)),
    series_id     = LTRIM(RTRIM(series_id)),
    month_name    = LTRIM(RTRIM(month_name)),
    quarter       = LTRIM(RTRIM(quarter));

UPDATE staging_table 
SET industry_name = REPLACE(industry_name, '  ', ' '),
    series_id = REPLACE(series_id, '  ', ' '),
    month_name = REPLACE(month_name, '  ', ' '),
    quarter = REPLACE(quarter, '  ', ' ');

UPDATE staging_table
SET industry_name = REPLACE(industry_name, CHAR(9),''),
    series_id = REPLACE(series_id, CHAR(9),''),
    month_name = REPLACE(month_name, CHAR(9),''),
    quarter = REPLACE(quarter, CHAR(9),'');