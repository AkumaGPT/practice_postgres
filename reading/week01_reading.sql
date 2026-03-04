-- test connection
SELECT 1;

-- create table syntax - CREATE TABLE table_name (..);
CREATE TABLE IF NOT EXISTS customers (
customer_id INT,
full_name TEXT
);

-- created wrong table with spelling so had to drop/delete it
DROP TABLE IF EXISTS cutomers;

-- column + data type syntax - column_name TYPE [constraints]
CREATE TABLE IF NOT EXISTS products (
product_id INT,
name TEXT,
price NUMERIC(10,2) -- max 10 digits and only 2 numbers after decimal
);

-- create table syntax - CREATE TABLE column_name (col1 TYPE, col2 TYPE);
CREATE TABLE orders (
order_id INT,
customer_id INT,
order_date DATE
);

-- insert syntax 1 - INSERT INTO table_name (col1, col2) VALUES (val1, val2);
-- insert syntax 2 - INSERT INTO table_name (col1, col2) VALUES (..), (..), (..);
INSERT INTO customers (customer_id, full_name)
VALUES (1, 'Jessica Mma');

INSERT INTO customers (customer_id, full_name)
VALUES (2, 'Seth Fab'), (3, 'Joe Uch');

-- SELECT FROM TABLE syntax 1 - SELECT col1, col2 FROM table_name;
-- SELECT FROM TABLE syntax 2 - SELECT * FROM table_name;
SELECT * FROM customers;
SELECT full_name FROM customers;
SELECT customer_id FROM customers;
SELECT * FROM products;

-- WHERE syntax - SELECT FROM .. WHERE condition;
SELECT * FROM customers
WHERE customer_id = 2;

INSERT INTO products (price)
VALUES (2000), (1000), (9000), (4000);

SELECT * FROM products
WHERE price > 5000; -- no input yet

--ORDER syntax - SELECT FROM table ORDER BY col ASC; SELECT FROM table ORDER BY col DESC;
SELECT * FROM products
ORDER BY price ASC;

SELECT * FROM products
ORDER BY price DESC;

-- LIMIT syntax - SELECT .. FROM table LIMIT n;
SELECT * FROM customers
LIMIT 2;
