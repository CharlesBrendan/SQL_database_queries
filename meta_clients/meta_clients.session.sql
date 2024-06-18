--SELECT *
--FROM meta_clients;

SELECT SUM(CAST(revenue AS NUMERIC)) AS total_revenue
FROM meta_revenue;