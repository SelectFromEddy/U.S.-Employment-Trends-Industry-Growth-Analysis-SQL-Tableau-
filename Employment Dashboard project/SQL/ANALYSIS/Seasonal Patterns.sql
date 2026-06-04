SELECT 
	i.industry_name,
	d.month_name,

	AVG(f.employment) AS avg_monthly_employment,

	RANK() OVER( PARTITION BY AVG(f.employment) ORDER BY d.month_name DESC) AS busiest_month_rank

FROM fact_table AS f
JOIN dimindustry AS i ON i.industry_id = f.industry_id
JOIN dimDate AS d ON d.date_id = f.date_id
GROUP BY i.industry_name, d.month_name;
