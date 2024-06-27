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

--- selecting parent companies in the table meta_revenue.meta_clients
SELECT DISTINCT parent_company
FROM meta_revenue;

---Selecting only clients with facebook and geo_user is RU.
SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE parent_company = 'Facebook' AND geo_user = 'RU';

--- Query to filter parent company not facebook and geo_user RU.
SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE parent_company != 'Facebook' AND geo_user = 'RU';

---Retrieve the client_id based in RU and EXCEPT those running ads with facebook.

SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE geo_user = 'RU'
EXCEPT
SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE parent_company = 'Facebook';

--Using EXCEPT function
---Filter clients with intersect of geo_user RU and parent_company facebook.
SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE geo_user = 'RU'
EXCEPT
SELECT client_id, geo_user, parent_company
FROM meta_revenue
WHERE parent_company = 'Instagram';

