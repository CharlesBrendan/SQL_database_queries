-- The table from meta clients
SELECT *
FROM meta_clients;

--cleaning the data by reducing the character to make it joinaable,readable.
SELECT client_id,
SUBSTRING(client_id, 8) AS cleaned_client_id
FROM meta_clients
ORDER BY client_id ASC;

SELECT SUBSTRING(client_id, 8) AS id,-- changes client_id to id
client_id
FROM meta_clients
ORDER BY id ASC;

-- using CAST function to clean data
SELECT client_id,
CAST(SUBSTRING(client_id, 8) AS Numeric) AS new_clients_id
FROM meta_clients
ORDER BY new_clients_id ASC;