SELECT 
	i.industry_name,
	SUM(f.employment) AS total_employment,
	
	RANK() OVER (ORDER BY SUM(f.employment)DESC) AS rank_position,
	DENSE_RANK() OVER (ORDER BY SUM(f.employment)DESC) AS dense_rank

	FROM fact_table AS f
	JOIN dimindustry AS i ON f.industry_id = i.industry_id
	GROUP BY i.industry_name;
