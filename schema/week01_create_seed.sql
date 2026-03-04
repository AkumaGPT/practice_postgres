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