SELECT
	i.industry_name,
	AVG(f.employment) AS avg_employment,
	STDEV(f.employment) AS volatility,

	STDEV(f.employment) * 1.0 / AVG(f.employment) AS coefficient_of_variation

	FROM fact_table AS f
	JOIN dimindustry AS i ON i.industry_id = f.industry_id
	GROUP BY i.industry_name
	ORDER BY coefficient_of_variation DESC;
