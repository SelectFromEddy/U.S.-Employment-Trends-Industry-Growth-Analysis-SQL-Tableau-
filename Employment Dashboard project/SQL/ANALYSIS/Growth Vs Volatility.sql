WITH base_data AS (
    SELECT
        i.industry_name AS category,
        d.date AS date,
        f.employment AS metric
    FROM fact_table AS f
    JOIN dimindustry AS i ON f.industry_id = i.industry_id
    JOIN dimDate AS d ON f.date_id = d.date_id
),

growth_calc AS (
    SELECT
        category,

        MIN(metric) AS start_value,
        MAX(metric) AS end_value,

        -- Growth %
        (MAX(metric) - MIN(metric)) * 1.0 / NULLIF(MIN(metric), 0) * 100 AS growth_rate

    FROM base_data
    GROUP BY category
),

volatility_calc AS (
    SELECT
        category,
        STDEV(metric) AS volatility
    FROM base_data
    GROUP BY category
)

SELECT
    g.category,
    g.start_value,
    g.end_value,
    g.growth_rate,
    v.volatility,

   
    CASE 
        WHEN g.growth_rate > 0 AND v.volatility < 500 THEN 'High Growth / Stable'
        WHEN g.growth_rate > 0 AND v.volatility >= 500 THEN 'High Growth / Volatile'
        WHEN g.growth_rate <= 0 AND v.volatility < 500 THEN 'Low Growth / Stable'
        ELSE 'Low Growth / Volatile'
    END AS category_type

FROM growth_calc AS g
JOIN volatility_calc AS v 
    ON g.category = v.category

ORDER BY g.growth_rate DESC;