WITH base_data AS (
    SELECT
        i.industry_name AS category,
        d.date,
        f.employment AS metric
    FROM fact_table f
    JOIN dimindustry i ON f.industry_id = i.industry_id
    JOIN dimDate d ON f.date_id = d.date_id
),

growth_calc AS (
    SELECT
        category,
        MIN(metric) AS start_value,
        MAX(metric) AS end_value,
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
),

avg_values AS (
    SELECT 
        AVG(volatility) AS avg_vol,
        AVG(growth_rate) AS avg_growth
    FROM growth_calc g
    JOIN volatility_calc v ON g.category = v.category
)

SELECT
    g.category,
    g.growth_rate,
    v.volatility,

    CASE 
        WHEN g.growth_rate > a.avg_growth AND v.volatility < a.avg_vol THEN 'High Growth / Stable'
        WHEN g.growth_rate > a.avg_growth AND v.volatility >= a.avg_vol THEN 'High Growth / Volatile'
        WHEN g.growth_rate <= a.avg_growth AND v.volatility < a.avg_vol THEN 'Low Growth / Stable'
        ELSE 'Low Growth / Volatile'
    END AS category_type

FROM growth_calc g
JOIN volatility_calc v ON g.category = v.category
CROSS JOIN avg_values a;