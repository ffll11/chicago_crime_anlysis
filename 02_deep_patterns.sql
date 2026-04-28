SELECT *
FROM chicago_crime;

--Tendencias Mensuales
-- Monthly growth and momentum

WITH crimes_per_month AS (
	SELECT 
		COUNT(id) as total_crimes , 
		EXTRACT(MONTH FROM date_occurrence ) as monthh
	FROM chicago_crime
	GROUP BY monthh 
	ORDER BY monthh 
)

SELECT 
	monthh,total_crimes,
	LAG(total_crimes) OVER(ORDER BY monthh) previous_crimes,
	total_crimes - LAG(total_crimes) OVER(ORDER BY monthh) as difference,
	ROUND(((total_crimes - LAG(total_crimes) OVER(ORDER BY monthh))::numeric / 
	        NULLIF(LAG(total_crimes) OVER(ORDER BY monthh), 0)) * 100, 2) || '%' as crecimiento_momentum
FROM crimes_per_month

--Ranking crimenes por distrito
--GEOSPATIAL RANKING: Top crime types partitioned by district

WITH crimes_per_district AS  
(
	SELECT 
		district ,primary_type,
		COUNT(*) total_crimes
	FROM chicago_crime
	GROUP BY district ,primary_type

)
SELECT 
	district,total_crimes, primary_type,
	RANK() OVER(PARTITION BY district ORDER BY total_crimes DESC)

FROM crimes_per_district

--El Índice de Resolución (Arrestos) Acumulado
--Running total of arrests (Resolution Rate)

WITH monthly_arrests AS (

	SELECT 
		DATE_TRUNC('month', date_occurrence) as monthh,
		SUM(CASE WHEN arrest = true THEN  1  ELSE 0 END )as monthly_arrest
	FROM chicago_crime
	GROUP BY  1
)

SELECT 
	monthh,monthly_arrest,
	SUM(monthly_arrest) OVER (ORDER BY monthh) as yearly_count --acumulative

FROM monthly_arrests
ORDER BY monthh