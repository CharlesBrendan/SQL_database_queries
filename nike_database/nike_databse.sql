--SELECT * FROM customers;

WITH items_combined AS 
(SELECT * FROM order_items
UNION ALL
SELECT *
FROM order_items_vintage),

orders_per_customer AS
(SELECT user_id,
COUNT(order_item_id) AS total_orders_items
FROM items_combined
GROUP BY user_id)

SELECT CASE WHEN total_orders_items = 1 THEN 'Single Customer'
WHEN total_orders_items > 1 THEN 'Recurring Customer'
ELSE 'Other'
END AS customer_group,
COUNT(user_id) AS total_customers

FROM orders_per_customer
GROUP BY customer_group
;
