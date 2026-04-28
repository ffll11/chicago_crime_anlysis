SELECT *
FROM chicago_crime 
--First 10 records
SELECT *
FROM chicago_crime 
ORDER BY id 
LIMIT 10;
--Last 10 records

SELECT *
FROM chicago_crime 
ORDER BY id desc 
LIMIT 10;

-- Total de registros y el rango temporal
SELECT 
    COUNT(*) AS total_registros,
    MIN(date) AS fecha_inicio,
    MAX(date) AS fecha_fin,
    COUNT(DISTINCT primary_type) AS tipos_crimen_unicos,
    COUNT(DISTINCT district) AS distritos_unicos
FROM chicago_crime;

--No datos null o inconsistentes

SELECT 
    SUM(CASE WHEN location_description IS NULL THEN 1 ELSE 0 END) AS nulos_localizacion,
    SUM(CASE WHEN district IS NULL THEN 1 ELSE 0 END) AS nulos_distrito,
    SUM(CASE WHEN latitude IS NULL OR longitude IS NULL THEN 1 ELSE 0 END) AS nulos_geograficos
FROM chicago_crime;

---- Top 10 tipos de crímenes y su peso porcentual sobre el total

SELECT
primary_type,
COUNT(*)  as total,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) || '%' AS porcentaje_del_total
FROM chicago_crime
GROUP BY primary_type
ORDER BY total desc
LIMIT 10;

-- Top 5 lugares más frecuentes para incidentes
SELECT
location_description,
COUNT(*) AS frecuencia
FROM chicago_crime
GROUP BY location_description
ORDER BY frecuencia desc
LIMIT 5;


