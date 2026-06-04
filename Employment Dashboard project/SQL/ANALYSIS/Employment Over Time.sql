SELECT 
d.date,
i.industry_name,
SUM(f.employment) as employment
FROM fact_table as f
JOIN dimDate as d ON d.date_id = f.date_id
JOIN dimIndustry as i ON i.industry_id = f.industry_id
GROUP BY d.date, i.industry_name 
ORDER BY d.date;