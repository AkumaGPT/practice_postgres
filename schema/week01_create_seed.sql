-- delete tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

--create customer table
CREATE TABLE customers (
customer_id INT PRIMARY KEY, -- must be unique and not empty
full_name TEXT NOT NULL -- name must be provided
);

-- create prodcuts table
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name       TEXT NOT NULL,
  price      NUMERIC(10,2) NOT NULL
);

--create orders table
CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(customer_id),
  order_date  DATE NOT NULL
);

--create order_items table
CREATE TABLE order_items (
  order_id   INT NOT NULL REFERENCES orders(order_id),
  product_id INT NOT NULL REFERENCES products(product_id),
  qty        INT NOT NULL,
  PRIMARY KEY (order_id, product_id)
);

INSERT INTO customers (customer_id, full_name) VALUES
(1, 'Ada Okafor'),
(2, 'Bola Musa'),
(3, 'Chidi Nwosu');

INSERT INTO products (product_id, name, price) VALUES
(10, 'Extension Cable', 7500.00),
(11, 'LED Bulb', 1200.00),
(12, 'Power Bank', 18000.00),
(13, 'Phone Charger', 3500.00);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(100, 1, '2026-03-01'),
(101, 2, '2026-03-02'),
(102, 1, '2026-03-02');

INSERT INTO order_items (order_id, product_id, qty) VALUES
(100, 10, 1),
(100, 11, 4),
(101, 12, 1),
(102, 11, 2),
(102, 13, 1);

SELECT COUNT(*) FROM customers; -- count total no of rows from customers table

-- see all the tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- mini project contd
--Add 2 new products and 1 new order with 2 items
SELECT * FROM products;

INSERT INTO products (product_id, name, price) VALUES 
(14, 'Laptop Charger', 10000),
(15, 'Adapter', 1000);

SELECT *  FROM products;

SELECT * FROM orders;
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(103, 3, '2026-03-04');

SELECT * FROM orders;