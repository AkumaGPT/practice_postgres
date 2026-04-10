DROP INDEX IF EXISTS idx_bc_order_customer_id;
DROP INDEX IF EXISTS idx_bc_order_item_order_id;

-- LAB task 1 - create indexes where it makes sense
CREATE INDEX IF NOT EXISTS idx_bc_order_customer_id
ON bootcamp.bc_order (customer_id);

CREATE INDEX IF NOT EXISTS idx_bc_order_item_order_id
ON bootcamp.bc_order_item (order_id);

-- LAB task 2 - EXPLAIN before and after index usage
EXPLAIN
SELECT *
FROM bootcamp.bc_order
WHERE customer_id = 1;


EXPLAIN ANALYZE
SELECT *
FROM bootcamp.bc_order
WHERE customer_id = 1;

--LAB task 3 - Upsert customers by email
INSERT INTO bootcamp.bc_customer (full_name, email)
VALUES ('Amaka.C', 'amaka@test.com')
ON CONFLICT (email)
DO UPDATE SET full_name = EXCLUDED.full_name
RETURNING *;

--LAB task 4 - safe update pattern
-- preview first
SELECT * FROM bootcamp.bc_customer WHERE email = 'tunde@test.com';

BEGIN;

UPDATE bootcamp.bc_customer
SET full_name = 'tundeed'
WHERE email = 'tunde@test.com'
RETURNING *;

ROLLBACK;

-- LAB task 5 - create a team report view report
CREATE OR REPLACE VIEW bootcamp.v_orders_report AS
SELECT o.order_id,
       o.order_date,
       c.full_name,
       o.total_amount
FROM bootcamp.bc_order o
JOIN bootcamp.bc_customer c ON c.customer_id = o.customer_id;

SELECT * FROM bootcamp.v_orders_report ORDER BY total_amount DESC;