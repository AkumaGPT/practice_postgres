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