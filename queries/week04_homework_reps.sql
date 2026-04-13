-- Insert 1 new customer (use RETURNING)
INSERT INTO bootcamp.bc_customer (customer_id, full_name, email) VALUES 
(4,'Bola.O', 'bolaolu@test.com')
RETURNING full_name, email;

-- Update that customer’s email (use RETURNING)
UPDATE bootcamp.bc_customer
SET email = 'olubola4@test.com'
WHERE full_name = 'Bola.O'
RETURNING full_name, email;

-- SELECT * FROM bootcamp.bc_customer
SELECT * FROM bootcamp.bc_customer;

-- Begin a transaction, update a customer email, then ROLLBACK (prove it with SELECT)
BEGIN;

UPDATE bootcamp.bc_customer
SET email = 'tundeed@test.com'
WHERE full_name = 'Tunde A.';

ROLLBACK;

-- Begin a transaction, insert a customer, then COMMIT (prove it with SELECT)
BEGIN;

INSERT INTO bootcamp.bc_customer (customer_id, full_name, email)
VALUES (5, 'Obi.C.', 'obinnak@test.com');

COMMIT;


-- Insert a new order for customer_id = 1 with total_amount = 0 (RETURNING order_id)
INSERT INTO bootcamp.bc_order (customer_id, order_date, total_amount)
VALUES (1, '2023-03-03', 0)
RETURNING order_id;

-- Insert 2 items for that order
INSERT INTO bootcamp.bc_order_item (order_id, item_name, qty, unit_price) VALUES
(3, 'Electric Kettle', 1, 18000),
(3, 'Extension', 2, 7000);

-- Update the order total using SUM(qty*unit_price) subquery (RETURNING total)

BEGIN;

UPDATE bootcamp.bc_order o
SET total_amount = (SELECT COALESCE(SUM(qty*unit_price), 0)
FROM bootcamp.bc_order_item oi
WHERE oi.order_id = o.order_id
)
WHERE o.order_id = 3
RETURNING total_amount

ROLLBACK;

-- show all orders with customer name (JOIN)
SELECT o.order_id, o.customer_id, c.full_name, o.order_date, o.total_amount
FROM bootcamp.bc_order o
JOIN bootcamp.bc_customer c
ON c.customer_id = o.customer_id 
ORDER BY o.order_id;

-- Show total spent per customer (GROUP BY) from bc_order
SELECT customer_id, SUM(total_amount) AS total_spent
FROM bootcamp.bc_order
GROUP BY customer_id;

-- Create a view bootcamp.v_orders_report that shows: order_id, order_date, full_name, total_amount
CREATE VIEW bootcamp.v_orders_report AS
SELECT order_id, order_date, full_name, total_amount
FROM bootcamp.bc_order o
JOIN bootcamp.bc_customer c
ON c.customer_id = o.customer_id 
ORDER BY o.order_id;

-- Select from bootcamp.v_orders_report ordered by total_amount DESC LIMIT 10
SELECT * FROM bootcamp.v_orders_report
ORDER BY total_amount DESC;


'''SESSSION B'''

-- EXPLAIN a query that joins bc_order to bc_customer
EXPLAIN
SELECT o.order_id, c.customer_id, c.full_name, o.total_amount
FROM bootcamp.bc_order o
JOIN bootcamp.bc_customer c
ON o.customer_id = c.customer_id
ORDER BY total_amount DESC;

-- EXPLAIN a query that joins bc_order to bc_customer
EXPLAIN ANALYZE
SELECT o.order_id, c.customer_id, c.full_name, o.total_amount
FROM bootcamp.bc_order o
JOIN bootcamp.bc_customer c
ON o.customer_id = c.customer_id
ORDER BY total_amount DESC;

-- Create an index on bootcamp.bc_customer(email) (IF NOT EXISTS)
CREATE INDEX IF NOT EXISTS idx_bc_customer_email
ON bootcamp.bc_customer (email);

-- Write an UPSERT that updates full_name when email conflicts
INSERT INTO bootcamp.bc_customer (full_name, email)
VALUES ('Obi K.', 'obinnak@test.com')
ON CONFLICT (email)
DO UPDATE SET full_name = EXCLUDED.full_name
RETURNING *;

-- Write an UPSERT that does NOTHING when email conflicts
INSERT INTO bootcamp.bc_customer (full_name, email)
VALUES ('Obi jj.', 'obinnak@test.com')
ON CONFLICT (email)
DO NOTHING;

-- Preview a customer row, then UPDATE it inside BEGIN/ROLLBACK
SELECT * FROM bootcamp.bc_customer WHERE customer_id = 3;

BEGIN;

UPDATE bootcamp.bc_customer
SET email = 'zaini@test.com'
WHERE customer_id = 3;

ROLLBACK;

-- Insert a new order for customer 1 and RETURNING order_id
INSERT INTO bootcamp.bc_order (customer_id, order_date, total_amount) 
VALUES (1, '2026-04-12', 0)
RETURNING order_id;

-- Insert 2 items for that order
INSERT INTO bootcamp.bc_order_item (order_id, item_name, qty, unit_price) 
VALUES (4, 'Switch', 2, 2000),
(4, 'Plug', 4, 1200);

-- Update total_amount using SUM(qty*unit_price) (RETURNING total_amount)
UPDATE bootcamp.bc_order o
SET total_amount = (SELECT COALESCE(SUM(qty*unit_price), 0)
FROM bootcamp.bc_order_item oi
WHERE o.order_id = oi.order_id
)
WHERE o.order_id = 4
RETURNING o.total_amount DESC;

-- Select from bootcamp.v_orders_report ordered by date DESC limit 10
SELECT * FROM bootcamp.v_orders_report ORDER BY order_date DESC;


-- Mini-Project

BEGIN;

UPDATE bootcamp.bc_customer
SET email = 'zainab@test.com'
WHERE customer_id = 3
RETURNING *;

COMMIT;

INSERT INTO bootcamp.bc_customer (full_name, email) VALUES 
('Amaka Kalu', 'amaka@test.com'),
('Tunde Edward', 'tundeed@test.com'),
('Zainab A.', 'zainab@test.com')
ON CONFLICT (email)
DO UPDATE SET full_name = EXCLUDED.full_name
RETURNING *;

