-- Total number of unique ZIP code regions --
SELECT COUNT(DISTINCT geolocation_zip_code_prefix) AS total_zip_regions
FROM geolocation;

-- Count how many cities and states are represented --
SELECT COUNT(DISTINCT geolocation_city) AS unique_cities,
       COUNT(DISTINCT geolocation_state) AS unique_states
FROM geolocation;

-- List of states with the number of ZIP codes covered --
SELECT geolocation_state,
       COUNT(DISTINCT geolocation_zip_code_prefix) AS zip_count
FROM geolocation
GROUP BY geolocation_state
ORDER BY zip_count DESC;

-- Top 10 cities with the most ZIP code coverage --
SELECT geolocation_city,
       COUNT(DISTINCT geolocation_zip_code_prefix) AS zip_count
FROM geolocation
GROUP BY geolocation_city
ORDER BY zip_count DESC
LIMIT 10;

-- Average latitude and longitude by state --
 SELECT geolocation_state,
        ROUND(AVG(geolocation_lat), 6) AS avg_latitude,
        ROUND(AVG(geolocation_lng), 6) AS avg_longitude
FROM geolocation
GROUP BY geolocation_state
ORDER BY geolocation_state;

-- Find duplicate ZIP code entries --
SELECT geolocation_zip_code_prefix,
       COUNT(*) AS occurrences
FROM geolocation
GROUP BY geolocation_zip_code_prefix
HAVING occurrences > 1
ORDER BY occurrences DESC;

-- Distribution of ZIP codes per city within each state --
SELECT geolocation_state,
       geolocation_city,
       COUNT(DISTINCT geolocation_zip_code_prefix) AS zip_count
FROM geolocation
GROUP BY geolocation_state, geolocation_city
ORDER BY geolocation_state, zip_count DESC;

-- Identify geographic center of the entire dataset --
SELECT ROUND(AVG(geolocation_lat), 6) AS center_latitude,
       ROUND(AVG(geolocation_lng), 6) AS center_longitude
FROM geolocation;






