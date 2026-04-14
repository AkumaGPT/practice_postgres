-- Report 1 — KPI Summary
SELECT SUM(amount) AS total_revenue,
	   COUNT(*) AS total_payments,
	   COUNT(DISTINCT customer_id) AS active_customers
FROM payment;

-- Report 2 — Daily revenue (last 14 days)
WITH daily AS (
	SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
	FROM payment
	GROUP BY DATE(payment_date)
)
SELECT *
FROM daily
ORDER BY DAY DESC
LIMIT 14;

-- Report 3 — Monthly revenue (last 6 months)
WITH monthly AS (
	SELECT DATE_TRUNC('month', payment_date) AS month, SUM(amount) AS monthly_revenue
	FROM payment
	GROUP BY DATE_TRUNC('month', payment_date)
)
SELECT *
FROM monthly
ORDER BY month DESC
LIMIT 6;

-- Report 4 — Top 10 customers by total spend
WITH spend AS (
	SELECT customer_id, SUM(amount) AS total_spent
	FROM payment
	GROUP BY customer_id
)
SELECT s.customer_id, c.first_name, c.last_name, total_spent
FROM spend s
JOIN customer c
ON s.customer_id = c.customer_id 
ORDER BY total_spent DESC
LIMIT 10;

-- Report 5 — Top 10 films by rental count
SELECT f.film_id, f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i 
ON i.inventory_id = r.inventory_id 
JOIN film f 
ON f.film_id = i.film_id 
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;