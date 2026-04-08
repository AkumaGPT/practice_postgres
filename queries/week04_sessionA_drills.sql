-- LAB task 1
DROP VIEW IF EXISTS bootcamp.v_customer_spend;
DROP TABLE IF EXISTS bootcamp.bc_order_item;
DROP TABLE IF EXISTS bootcamp.bc_order;
DROP TABLE IF EXISTS bootcamp.bc_customer;

CREATE TABLE bootcamp.bc_customer (
  customer_id SERIAL PRIMARY KEY,
  full_name   TEXT NOT NULL,
  email       TEXT UNIQUE
);

CREATE TABLE bootcamp.bc_order (
  order_id     SERIAL PRIMARY KEY,
  customer_id  INT NOT NULL REFERENCES bootcamp.bc_customer(customer_id),
  order_date   DATE NOT NULL DEFAULT CURRENT_DATE,
  total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0)
);

CREATE TABLE bootcamp.bc_order_item (
  order_id   INT NOT NULL REFERENCES bootcamp.bc_order(order_id),
  item_name  TEXT NOT NULL,
  qty        INT NOT NULL CHECK (qty > 0),
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
  PRIMARY KEY (order_id, item_name)
);

-- LAB task 2
INSERT INTO bootcamp.bc_customer (full_name, email) VALUES
('Amaka.N', 'amaka@test.com'),
('Tunde A.', 'tunde@test.com'),
('Zainab K.', NULL)
RETURNING customer_id, full_name, email;

-- Lab Task 3 — Insert orders + items inside a transaction
BEGIN;

-- create 2 orders
INSERT INTO bootcamp.bc_order(customer_id, order_date, total_amount)
VALUES
(1, '2026-03-03', 0),
(2, '2026-03-03', 0)
RETURNING order_id, customer_id;

-- Add items for order 1
INSERT INTO bootcamp.bc_order_item(order_id, item_name, qty, unit_price)
VALUES
(1, 'LED Bulb', 4, 1200.00),
(1, 'Phone Charger', 1, 3500.00);

-- Add items for order 2
INSERT INTO bootcamp.bc_order_item (order_id, item_name, qty, unit_price)
VALUES
(2, 'Power Bank', 1, 18000.00);

-- Update totals using items
UPDATE bootcamp.bc_order o
	SET total_amount = (
	SELECT COALESCE (SUM(qty * unit_price), 0)
	FROM bootcamp.bc_order_item oi
	WHERE oi.order_id = o.order_id
	)
WHERE o.order_id IN (1,2)
RETURNING order_id, total_amount;

COMMIT;

-- Lab task 4 - prove rollback works
BEGIN;

UPDATE bootcamp.bc_customer
SET email = 'amaka@test.com'
WHERE customer_id = 1
RETURNING customer_id, full_name, email;

ROLLBACK;

SELECT customer_id, full_name, email
FROM bootcamp.bc_customer
WHERE customer_id = 1;

-- LAB task 5 - create a view
CREATE VIEW bootcamp.v_customer_spend AS
SELECT c.customer_id, c.full_name,
	COALESCE (SUM(o.total_amount), 0) AS total_spent
FROM bootcamp.bc_order o
LEFT JOIN bootcamp.bc_customer c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
	
SELECT * FROM bootcamp.v_customer_spend
ORDER BY total_spent DESC;