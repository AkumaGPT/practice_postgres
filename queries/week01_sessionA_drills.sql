-- show all customers
SELECT * FROM customers;

-- show only full_name from customers
SELECT full_name FROM customers;

-- show products that cost more than 5000
SELECT price FROM products
WHERE price > 5000;

-- show products sorted by price high to low
SELECT * FROM products
ORDER BY price DESC;

-- show the cheapest 2 products
SELECT * FROM products
ORDER BY price ASC
LIMIT 2;

-- show orders from 2026-03-02
SELECT * FROM orders
WHERE order_date = '2026-03-02'

-- show cutomers with customer_id 1 or 3
SELECT * FROM customers
WHERE customer_id != 2;

-- show products with price between 2000 and 10000
SELECT * FROM products
WHERE price >= 2000 AND price <= 10000;