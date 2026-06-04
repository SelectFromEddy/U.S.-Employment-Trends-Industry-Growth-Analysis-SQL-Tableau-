WITH growth_calc AS (

SELECT 
	i.industry_name,
	MIN(d.date) AS start_date,
	MAX(d.date) AS end_date,
	MIN(f.employment) AS start_value,
	MAX(f.employment) AS end_value
FROM fact_table AS f
JOIN dimDate AS d ON d.date_id = f.date_id
JOIN dimIndustry AS i ON i.industry_id = f.industry_id
GROUP BY i.industry_name
)
SELECT 
	industry_name,
	start_value,
	end_value,

   (end_value - start_value) * 1.0 / start_value * 100 AS growth_percent
   FROM growth_calc
   ORDER BY growth_percent DESC;