SELECT *
FROM walmart_sales.walmart_sales_staging
LIMIT 10
;

SELECT store, AVG(Temperature), MIN(Temperature), MAX(Temperature)
FROM walmart_sales.walmart_sales_staging
GROUP BY store
;

-- Get the average of temps, fuel_price, CPI, Unemployment
SELECT AVG(avg_temp_per_store), MIN(min_temp), MAX(max_temp)
FROM
(
SELECT store, AVG(Temperature) AS avg_temp_per_store, MIN(Temperature) min_temp, MAX(Temperature) max_temp
FROM walmart_sales.walmart_sales_staging
GROUP BY store
) AS avg_temp
;

SELECT AVG(avg_fp_per_store), MIN(min_fp), MAX(max_fp)
FROM
(
SELECT store, AVG(Fuel_Price) AS avg_fp_per_store, MIN(Fuel_Price) min_fp, MAX(Fuel_Price) max_fp
FROM walmart_sales.walmart_sales_staging
GROUP BY store
) AS avg_fp
;

SELECT AVG(avg_cpi_per_store), MIN(min_cpi), MAX(max_cpi)
FROM
(
SELECT store, AVG(CPI) AS avg_cpi_per_store, MIN(CPI) min_cpi, MAX(CPI) max_cpi
FROM walmart_sales.walmart_sales_staging
GROUP BY store
) AS avg_cpi
;

SELECT AVG(avg_unemployment_per_store), MIN(min_Unemployment), MAX(max_Unemployment)
FROM
(
SELECT store, AVG(Unemployment) AS avg_unemployment_per_store, MIN(Unemployment) min_Unemployment, MAX(Unemployment) max_Unemployment
FROM walmart_sales.walmart_sales_staging
GROUP BY store
) AS avg_Unemployment
;

