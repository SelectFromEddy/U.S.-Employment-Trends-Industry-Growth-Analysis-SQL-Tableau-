 SELECT 
 i.industry_name,
 SUM(f.employment) AS total_employment
 FROM fact_table AS f
 JOIN dimindustry AS i ON f.industry_id = i.industry_id
 
 GROUP BY i.industry_name
 ORDER BY total_employment DESC;
