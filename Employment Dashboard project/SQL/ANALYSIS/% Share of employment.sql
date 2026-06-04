SELECT 
i.industry_name,
SUM(f.employment) as total_jobs,
SUM(f.employment) * 100.0 / SUM(SUM(f.employment)) OVER() as percent_share
FROM fact_table as f
JOIN dimIndustry as i ON i.industry_id = f.industry_id
GROUP BY i.industry_name
ORDER BY percent_share;
