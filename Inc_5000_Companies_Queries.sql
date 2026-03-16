CREATE DATABASE finance;

USE finance;

SELECT * FROM inc_5000
LIMIT 10;

-- 1. CALCULATE TOTAL NUMBER OF UNIQUE COMPANIES
SELECT (COUNT(DISTINCT name)) AS name_count
FROM inc_5000;

-- 2. WHICH INDUSTRIES ARE MOST AND LEAST REPRESENTED IN THE LIST
SELECT industry, 
(COUNT(*)) AS industry_count
FROM inc_5000
GROUP BY industry
ORDER BY industry_count DESC;

SELECT industry, 
(COUNT(*)) AS industry_count
FROM inc_5000
GROUP BY industry
ORDER BY industry_count;

-- 3. GEOGRAPHIC TRENDS USING REVENUE AMONG CITIES 
SELECT city, 
SUM(revenue) AS total_revenue
FROM Inc_5000
GROUP BY city
ORDER BY total_revenue DESC;

-- 3. SHOW AVERAGE REVENUE AMONG COMAPANIES BROKEN DOWN BY INDUSTRY
SELECT industry,
ROUND(AVG(revenue),2)  AS avg_revenue
FROM inc_5000
GROUP BY industry;

-- 4. WHICH INDUSTIES SAW THE LARGEST AVERAGE GROWTH RATE
SELECT industry,
ROUND(AVG(`growth_%`), 2) AS avg_growth
FROM inc_5000
GROUP BY industry
ORDER BY avg_growth DESC
LIMIT 10;

-- 5. DID ANY COMAPANY INCREASE REVENUE WHILE REDUCING STAFF
with updated_inc_5000 AS (
SELECT name, founded,
`growth_%`,
ROUND((((workers - previous_workers) / previous_workers) * 100),2) AS pct_staff_turnover
FROM  inc_5000
)
SELECT
name, founded, `growth_%`, pct_staff_turnover
FROM updated_inc_5000
WHERE `growth_%` > 0
AND pct_staff_turnover < 0
ORDER BY founded DESC;

-- 6. WHICH COMPANIES HAD THE LARGEST INCREASE IN STAFF/NEW HIRES (SHOW ONLY THE FIRST 10)
SELECT name,
(workers - previous_workers) AS staff_turnover
FROM inc_5000
ORDER BY staff_turnover DESC
LIMIT 10;

-- 7. SHOW INDUSTRIES AVERAGE STAFF TURNOVER 
SELECT industry,
AVG(workers - previous_workers) AS avg_staff_turnover
FROM inc_5000
GROUP BY industry
ORDER BY avg_staff_turnover DESC
LIMIT 10;

-- 8. WHICH INDUSTRIES HAD THE LARGEST STAFF TURNOVER
SELECT industry,
sum(workers - previous_workers) AS staff_turnover
FROM inc_5000
GROUP BY industry
ORDER BY staff_turnover DESC
LIMIT 10;

-- 9. CALCULATE THREE PERFORMANCE METRICS- TOTAL REVENUE, AVERAGE REVENUE, TOTAL NUMBER OF COMPANIES IN EACH INDUSTRIES
SELECT industry,
COUNT(DISTINCT name) as company_count,
SUM(revenue) AS total_revenue,
ROUND(AVG(revenue),2) AS avg_revenue
FROM inc_5000
GROUP BY industry
ORDER BY total_revenue DESC;

-- 10. SHOW TOP 10 INDUSTRIES WITH THE HIGHEST REVENUE AND 10 INDUSTRIES WITH THE LOWEST REVENUE
SELECT industry,
SUM(revenue) AS total_revenue
FROM inc_5000
GROUP BY industry
ORDER BY total_revenue DESC
LIMIT 10;

SELECT industry,
SUM(revenue) AS sum_revenue  
FROM inc_5000
GROUP BY industry
ORDER BY sum_revenue
LIMIT 10;


