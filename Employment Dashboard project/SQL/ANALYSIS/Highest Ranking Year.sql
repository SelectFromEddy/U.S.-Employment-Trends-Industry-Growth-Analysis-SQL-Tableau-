WITH rank_data AS (
SELECT
	i.industry_name,
	d.year,
	
	SUM(f.employment) AS total_jobs,

	RANK() OVER( PARTITION BY d.year ORDER BY SUM(f.employment) DESC) AS top_rank, 
	RANK() OVER( PARTITION BY d.year ORDER BY SUM(f.employment) ASC) AS bottom_rank

FROM fact_table AS f
JOIN dimDate AS d ON d.date_id = f.date_id
JOIN dimindustry AS i ON i.industry_id = f.industry_id 
GROUP BY d.year, i.industry_name 
	)

	SELECT *
	FROM rank_data 
	WHERE top_rank = 1 OR 
	bottom_rank = 1
	ORDER BY year ASC;