EXPLAIN ANALYZE
WITH crimes_per_district AS (
    SELECT district, primary_type, COUNT(*) as total_crimes
    FROM chicago_crime
    GROUP BY district, primary_type
)
SELECT *, RANK() OVER(PARTITION BY district ORDER BY total_crimes DESC)
FROM crimes_per_district;
--Execution Time: 5.056 ms

-- Creamos índices para acelerar los agrupamientos y filtros.

CREATE INDEX idx_crime_district ON chicago_crime (district);
CREATE INDEX idx_crime_date ON chicago_crime (date_occurrence);
CREATE INDEX idx_crime_type ON chicago_crime (primary_type)

--
EXPLAIN ANALYZE
WITH crimes_per_district AS (
    SELECT district, primary_type, COUNT(*) as total_crimes
    FROM chicago_crime
    GROUP BY district, primary_type
)
SELECT *, RANK() OVER(PARTITION BY district ORDER BY total_crimes DESC)
FROM crimes_per_district;

--Execution Time: 0.732 ms