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

'''SESSION B reading'''
SELECT table_schema, table_name
FROM information_schema.TABLES
WHERE table_schema = 'bootcamp'
ORDER BY table_name;

SELECT current_database()

-- INDEX syntax - CREATE INDEX index_name ON schema.table (col); 
-- for multi-column - CREATE INDEX index_name ON schema.table (col1, col2);

-- we'll frequently look up orders by customer_id:
CREATE INDEX idx_bc_order_customer_id ON bootcamp.bc_order (customer_id);

-- we'll frequently look up items in order_id:
CREATE INDEX idx_bc_order_item_order_id ON bootcamp.bc_order_item (order_id);

-- EXPLAIN syntax - EXPLAIN select ...; EXPLAIN ANALYZE select..; it runs and measures
EXPLAIN
SELECT *
FROM bootcamp.bc_order
WHERE customer_id = 1;

EXPLAIN ANALYZE
SELECT *
FROM bootcamp.bc_order
WHERE customer_id = 1;

-- UNIQUE syntax - ALTER TABLE schema.table ADD CONSTRAINT constraint_name UNIQUE (col);

-- UPSERT syntax - 

--INSERT INTO table (col1, col2)
-- ON CONFLICT (unique_col)
-- DO UPDATE SET col2 = EXCLUDED.col2
--RETURNING *;

-- or do nothing
--ON CONFLICT (unique_col) DO NOTHING;

-- if email already exist, update the name instead
INSERT INTO bootcamp.bc_customer (full_name, email)
VALUES ('Amaka Updated', 'amaka@test.com')
ON CONFLICT (email)
DO UPDATE SET full_name = EXCLUDED.full_name
RETURNING customer_id, full_name, email;

-- if email exsits, skip insert
INSERT INTO bootcamp.bc_customer (full_name, email)
VALUES ('should not insert', 'amaka@test.com')
ON CONFLICT (email)
DO NOTHING
RETURNING customer_id;

-- Query hygiene - good habits; explicit columns, always preview before UPDATE/DELETE, wrap risky changes in BEGIN/ROLLBACK first

--preview the update
SELECT * FROM bootcamp.bc_customer WHERE customer_id = 1

BEGIN;

UPDATE bootcamp.bc_customer
SET full_name = 'Amaka N.'
WHERE customer_id = 1
RETURNING *

COMMIT;