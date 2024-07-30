SELECT*
FROM customers
;

--Question 1: How many customers do we have in the data?
SELECT DISTINCT (customer_id)
FROM customers
;

--Question 2: What was the city with the most profit for the company in 2015?
SELECT SUM (order_profits) AS profit, order_date, shipping_date, shipping_city
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id
WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY order_date, shipping_date, shipping_city
ORDER BY profit DESC
;

--From the group
SELECT
		o.shipping_city AS city,
  	SUM(od.order_profits) AS profit
FROM order_details od
JOIN orders o
	ON od.order_id = o.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2015
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;

--Question 3: In 2015, what was the most profitable city's profit?
SELECT SUM(order_profits) AS profit
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id
WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31'
AND shipping_city = 'Minneapolis'
;

--Question 4: How many different cities do we have in the data?
SELECT COUNT(DISTINCT shipping_city)
FROM orders
;

--Question 8: What is the distribution of customer types in the data?
SELECT DISTINCT customer_segment
FROM customers;

SELECT customer_segment,
COUNT(*) AS dist_customer
FROM customers
GROUP BY customer_segment
ORDER BY dist_customer
;

--Question 11: Which customer got the most discount in the data? (in total amount)
SELECT customer_name, SUM(order_discount) AS total_discount
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY  c.customer_name
ORDER BY total_discount DESC
;

--Question 15: Display customer names for customers who are in the segment ‘Consumer’ or‘Corporate.’
--How many customers are there in total?
SELECT DISTINCT customer_name, customer_segment
FROM customers
WHERE customer_segment = 'Consumer'
OR  customer_segment = 'Corporate'
ORDER BY customer_name ASC
;

--How many in total
SELECT COUNT(*) AS total_number
FROM customers
WHERE customer_segment IN ('Consumer', 'Corporate')
;

WITH iowa_profitable_product AS(
  SELECT EXTRACT(YEAR FROM o.shipping_date) AS year, p.product_category, SUM(od.order_profits) AS annual_profit
  FROM product AS p
  INNER JOIN order_details AS od ON p.product_id = od.product_id
  INNER JOIN orders AS o ON od.order_id = o.order_id
  WHERE o.shipping_state = 'Iowa'
  GROUP BY year, p.product_category)
SELECT product_category, ROUND(AVG(annual_profit)::NUMERIC, 2) AS avg_profit
FROM iowa_profitable_product
GROUP BY product_category
ORDER BY avg_profit DESC
LIMIT 1
