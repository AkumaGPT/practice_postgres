-- Lab task 1 - rank paymenta
SELECT payment_id, customer_id, amount,
	RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rnk
FROM payment
LIMIT 10;

-- Lab task 2 - Top payment per customer
WITH ranked AS (
SELECT customer_id, payment_id, amount,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
FROM payment
)
SELECT customer_id, payment_id, amount, rn
FROM ranked
WHERE rn = 1
ORDER BY amount DESC 
LIMIT 10;

-- Lab task 3 - Daily revenue + running revenue
WITH daily AS (
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DAY
)
SELECT DAY, daily_revenue,
	SUM(daily_revenue) OVER (ORDER BY DAY) AS running_revenue
FROM daily
ORDER BY DAY
LIMIT 20;

-- Lab task 4 - 7-day moving average of revenue
WITH daily AS (
SELECT DATE(payment_date) AS DAY, AVG(amount) AS revenue_avg
FROM payment
GROUP BY DAY
)
SELECT DAY, revenue_avg,
	AVG(revenue_avg) OVER (ORDER BY DAY ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7
FROM daily
ORDER BY DAY
LIMIT 20;
