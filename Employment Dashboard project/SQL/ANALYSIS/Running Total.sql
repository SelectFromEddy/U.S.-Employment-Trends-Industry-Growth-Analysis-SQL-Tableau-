SELECT 
	i.industry_name,
	d.date,
	f.employment,

	SUM(f.employment) OVER(PARTITION BY i.industry_name ORDER BY d.date) AS running_total

	FROM fact_table AS f
	JOIN dimindustry AS i ON i.industry_id = f.industry_id
	JOIN dimDate AS d ON f.date_id = d.date_id;
