SELECT current_database();

SELECT table_name
FROM information_schema.TABLES
WHERE table_schema = 'public'
ORDER BY table_name

-- create a new schema
CREATE SCHEMA IF NOT EXISTS bootcamp;

-- drop tables
DROP VIEW IF EXISTS bootcamp.v_customer_spend;
DROP TABLE IF EXISTS bootcamp.bc_order_item;
DROP TABLE IF EXISTS bootcamp.bc_order;
DROP TABLE IF EXISTS bootcamp.bc_customer;

-- create tables with constraints
CREATE TABLE bootcamp.bc_customer(
customer_id SERIAL PRIMARY KEY, 
full_name TEXT NOT NULL,
email TEXT UNIQUE
);

CREATE TABLE bootcamp.bc_order(
order_id SERIAL PRIMARY KEY,
customer_id INT NOT NULL REFERENCES bootcamp.bc_customer(customer_id),
order_date DATE NOT NULL DEFAULT CURRENT_DATE,
total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0)
);

CREATE TABLE bootcamp.bc_order_item(
order_id INT NOT NULL REFERENCES bootcamp.bc_order(order_id),
item_name TEXT NOT NULL,
qty INT NOT NULL CHECK (qty > 0),
unit_price NUMERIC(10,2) NOT NULL CHECK (qty >= 0),
PRIMARY KEY (order_id, item_name)
);

SELECT * FROM bootcamp.bc_customer;

INSERT INTO bootcamp.bc_customer(full_name, email) VALUES 
('Amaka.N', 'amaka@test.com')

INSERT INTO bootcamp.bc_customer(full_name, email) VALUES 
('tunde.A', 'tunde@test.com')
RETURNING customer_id, full_name;

-- UPDATE SYNTAX - UPDATE col SET table_name WHERE condition RETURNING *
UPDATE bootcamp.bc_customer
SET email = 'amaka.new@test.com'
WHERE full_name = 'Amaka.N'
RETURNING *;

-- DELETE SYNTAX - DELETE FROM table_name WHERE condition RETURNING *
DELETE FROM bootcamp.bc_customer
WHERE email = 'tunde@test.com'
RETURNING customer_id, full_name;