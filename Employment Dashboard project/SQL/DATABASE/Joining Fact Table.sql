INSERT INTO fact_table (employment,date_id,industry_id)
SELECT 
s.employment,
d.date_id,
i.industry_id
FROM staging_table AS s
JOIN dimDate AS d
ON s.date = d.date
JOIN dimindustry AS i
ON s.industry_name = i.industry_name;
