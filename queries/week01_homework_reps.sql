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