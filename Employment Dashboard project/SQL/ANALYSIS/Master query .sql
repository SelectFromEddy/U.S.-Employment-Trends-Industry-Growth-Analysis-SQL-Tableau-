WITH base_data AS (
SELECT
i.industry_name,
d.date,
d.month,
d.year,
f.employment * 1000 AS employment
FROM fact_table AS f
JOIN dimindustry AS i
ON i.industry_id = f.industry_id
JOIN dimDate AS d
ON d.date_id = f.date_id
),
lagged AS (
SELECT
industry_name,
date,
month,
year,
employment,
LAG(employment) OVER (
PARTITION BY industry_name
ORDER BY date
) AS prev_month,
LAG(employment, 12) OVER (
PARTITION BY industry_name
ORDER BY date
) AS prev_year
FROM base_data
),
calculations AS (
SELECT
industry_name,
date,
month,
year,
employment,

CASE
WHEN prev_month IS NULL THEN NULL
ELSE employment - prev_month
END AS mom_change,

CASE
WHEN prev_month IS NULL OR prev_month = 0 THEN NULL
ELSE (employment - prev_month) * 1.0 / prev_month
END AS mom_growth,

CASE
WHEN prev_year IS NULL OR prev_year = 0 THEN NULL
ELSE (employment - prev_year) * 1.0 / prev_year
END AS yoy_growth,

AVG(employment) OVER (
PARTITION BY industry_name
ORDER BY date
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_average

FROM lagged
),
volatility_calc AS (
SELECT
industry_name,
STDEV(mom_growth) AS volatility_pct
FROM calculations
GROUP BY industry_name
)
SELECT
c.industry_name,
c.date,
c.month,
c.year,
c.employment,
c.mom_change,
c.mom_growth,
c.yoy_growth,
c.moving_average,
v.volatility_pct
FROM calculations c
LEFT JOIN volatility_calc v
ON c.industry_name = v.industry_name
WHERE c.industry_name <> 'Total nonfarm';