-- lab task 1
-- write a query that shows order_id, order_date and full_name
-- sorted by order_id asc, shows one row per order

SELECT * FROM orders;
SELECT * FROM customers;

SELECT o.order_id, o.order_date, c.full_name
FROM orders o
JOIN customers c
	ON c.customer_id = o.customer_id
ORDER BY o.order_id ASC;

--lab task 2
-- write a query that shows order_id, product_name, qty, unit_price
-- Uses order_items joined to products, Sorted by order_id, then product_name

SELECT * FROM order_items;
SELECT * FROM products;

SELECT oi.order_id, p.name, oi.qty, p.price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id 
ORDER BY oi.order_id

--lab task 3
-- Write a query that shows: order_id, total_amount = sum of qty * price for that order
-- Must use SUM(oi.qty * p.price), Must use GROUP BY order_id, Sorted by order_id

SELECT order_id, SUM(oi.qty * p.price) AS total_amount
FROM order_items oi
JOIN products p
	 ON oi.product_id = p.product_id
GROUP BY oi.order_id
ORDER BY oi.order_id;

-- lab task 4 
-- Write a query that shows: customer_id, full_name, total_spent
-- joins customers -> orders -> order_items -> products, groups by customer, sorted by total_spent DESC

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT o.customer_id, c.full_name, SUM(oi.qty * p.price) AS total_spent
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id 
JOIN order_items oi
	ON o.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY o.order_id, c.full_name
ORDER BY total_spent DESC;