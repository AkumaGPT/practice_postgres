SELECT current_database();

-- Fact table

-- payment is a fact table: each row is a payment event
SELECT COUNT(*) AS total_payments FROM payment;

SELECT DATE(payment_date) AS day, SUM(amount) AS revenue
FROM payment
GROUP BY DATE(payment_date)
ORDER BY day DESC
LIMIT 5;

-- Dimension table

-- customer is a dimension: names/details
SELECT customer_id, first_name, last_name
FROM customer
LIMIT 5;

-- revenue per customer (fact + dimension)
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Date Bucketing syntax - DAY - DATE(timestamp_col), MONTH - DATE_TRUNC('month', timestamp_col)
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DATE(payment_date)
ORDER BY DAY DESC
LIMIT 4;

SELECT DATE_TRUNC('month', payment_date) AS MONTH,
       SUM(amount) AS monthly_revenue
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY MONTH DESC
LIMIT 5;

-- Reusable report query - WITH step1 AS(..), step2 AS(..) SELECT .. FROM step2;
WITH daily AS (
	SELECT DATE(payment_date) AS DAY,
	       SUM(amount) AS daily_revenue
	FROM payment
	GROUP BY DATE(payment_date)
),
final AS (
	SELECT DAY, daily_revenue
	FROM daily
)
SELECT *
FROM final
ORDER BY DAY DESC
LIMIT 4;

-- KPI syntax - SELECT COUNT(*) AS kpi from table;, SELECT SUM(amount) AS kpi from payment;
SELECT SUM(amount) AS total_revenue FROM payment;

SELECT COUNT(DISTINCT customer_id) AS active_customers FROM customer;