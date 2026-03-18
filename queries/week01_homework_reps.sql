'''session A reps'''

-- list all products
SELECT * FROM products;

--list product names only
SELECT name FROM products;

--list products priced exactly 1200
SELECT * FROM products
WHERE price = 1200;

--list products priced > 3000 and < 15000
SELECT * FROM products
WHERE price > 3000 AND price < 15000;

--list customers sorted A→Z by name
SELECT * FROM customers
ORDER BY full_name ASC;

--list customers sorted Z→A
SELECT * FROM customers
ORDER BY full_name DESC;

--show the first 1 customer (any order)
SELECT * FROM customers
ORDER BY full_name ASC
LIMIT 1;

--show the first 2 orders sorted by date
SELECT * FROM orders
ORDER BY order_date ASC
LIMIT 2;

--show orders where customer_id = 1
SELECT * FROM orders
WHERE customer_id = 1;

--show products with price >= 3500
SELECT * FROM products
WHERE price >= 3500;

--show products with price <= 3500
SELECT * FROM products
WHERE price <= 3500;

'''session B reps'''

-- count total orders
SELECT COUNT(*) FROM orders;

-- count total prodcuts
SELECT COUNT(*) FROM products;

-- count order_items rows
SELECT count(*) FROM order_items;

-- Orders per customer (customer_id + count)
SELECT o.customer_id, count(o.customer_id) AS total_orders
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Orders per customer (full_name + count)
SELECT o.customer_id, count(o.customer_id) AS total_orders
FROM orders o
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Orders per customer (full_name + count)
SELECT * FROM orders;
SELECT * FROM customers;

SELECT o.customer_id, c.full_name, count(o.customer_id) AS total_orders
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.full_name
ORDER BY o.customer_id;

-- Total quantity sold per product_id
SELECT * FROM order_items;

SELECT oi.product_id, SUM(oi.qty) AS total_quantity
FROM order_items oi
GROUP BY oi.product_id
ORDER BY oi.product_id

-- Total quantity sold per product name
SELECT * FROM products;

SELECT p.name, sum(oi.qty) AS total_quantity
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY p.name

-- Total revenue per order_id
SELECT * FROM products;
SELECT * FROM order_items;

SELECT oi.order_id, SUM(oi.qty * p.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id 
GROUP BY oi.order_id
ORDER BY oi.order_id

-- Total revenue per customer name
SELECT * FROM orders;

SELECT c.full_name, SUM(oi.qty * p.price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
	ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.full_name
ORDER BY c.full_name;

-- Top 1 highest spending customer