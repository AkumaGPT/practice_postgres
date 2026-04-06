-- Add row numbers to payments ordered by payment_date DESC (limit 20)

SELECT payment_id, DATE(payment_date) AS DAY,
	ROW_NUMBER() OVER (ORDER BY DATE(payment_date) DESC) AS rn
FROM payment
LIMIT 20;

-- Add row numbers per customer ordered by payment_date DESC (limit 50)
SELECT customer_id, DATE(payment_date) AS DAY,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY DATE(payment_date) DESC) AS rn
FROM payment
LIMIT 50;

-- Rank customers by total_spent (CTE + SUM + RANK) top 20
WITH spend AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
)
SELECT customer_id, total_spent,
	RANK() OVER (ORDER BY total_spent) AS rnk
FROM spend
ORDER BY total_spent DESC
LIMIT 20;

-- Dense rank customers by total_spent (same query but DENSE_RANK) top 20
WITH spend AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
)
SELECT customer_id, total_spent,
	DENSE_RANK() OVER (ORDER BY total_spent) AS dense_rnk
FROM spend
ORDER BY total_spent DESC
LIMIT 20;

-- Daily revenue table (day, daily_revenue) last 30 days (order by day DESC limit 30)
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DAY
ORDER BY DAY DESC
LIMIT 30;

-- Running revenue from the daily table (order by day) limit 30
WITH daily AS (
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DAY
)
SELECT DAY, daily_revenue,
	SUM(daily_revenue) OVER (ORDER BY DAY) AS running_revenue
FROM daily
ORDER BY DAY
LIMIT 30;

-- 7-day moving average on daily revenue (limit 30)
WITH daily AS (
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DAY
ORDER BY DAY DESC
)
SELECT DAY, daily_revenue,
	AVG(daily_revenue) OVER (ORDER BY DAY ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7
FROM daily
ORDER BY DAY
LIMIT 30;

-- Top 2 payments per customer (ROW_NUMBER partition + rn <= 2) limit 50
WITH spend AS (
	SELECT customer_id, amount,
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
	FROM payment
)
SELECT customer_id, amount
FROM spend
WHERE rn <= 2
LIMIT 50;

-- Top 3 customers per staff by revenue collected (staff_id partition; rank by SUM(amount))
WITH spend AS (
	SELECT customer_id, staff_id, SUM(amount) AS total_spent
	FROM payment
	GROUP BY customer_id, staff_id
)
SELECT customer_id, staff_id, total_spent
FROM (
	SELECT *,
		RANK() OVER (PARTITION BY staff_id ORDER BY total_spent DESC) AS rnk
	FROM spend
) t
WHERE rnk <= 3
LIMIT 20;

-- Rank films by rental count (join rental→inventory→film; count rentals; rank) top 20
SELECT title, COUNT(*) AS rental_count,
	RANK() OVER (ORDER BY COUNT(rental_rate) DESC) AS rank
FROM rental r
JOIN inventory i
	ON i.inventory_id = r.inventory_id 
JOIN film f
	ON f.film_id = i.film_id
GROUP BY title
ORDER BY COUNT(*) DESC
LIMIT 20;

-- Dense rank films by rental count (same) top 20
SELECT title, COUNT(rental_rate) AS rental_count,
	DENSE_RANK() OVER (ORDER BY COUNT(rental_rate) DESC) AS rank
FROM rental r
JOIN inventory i
	ON i.inventory_id = r.inventory_id 
JOIN film f
	ON f.film_id = i.film_id
GROUP BY title
ORDER BY COUNT(rental_rate) DESC
LIMIT 20;

-- Find ties: list films that share the same rental_count as another film (hint: use a CTE and count occurrences)
WITH rent AS (
SELECT f.film_id, f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
),
counts AS (
SELECT rental_count
FROM rent
GROUP BY rental_count
HAVING COUNT(*) > 1
)
SELECT *
FROM rent
WHERE rental_count IN (SELECT rental_count FROM counts)
LIMIT 4;

-- Mini Project

-- Revenue dashboard for last 14 days
WITH daily AS (
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DAY
ORDER BY DAY DESC
)
SELECT DAY, daily_revenue,
	SUM(daily_revenue) OVER (ORDER BY DAY DESC) AS running_revenue,
	AVG(daily_revenue) OVER (ORDER BY DAY DESC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7
FROM daily
ORDER BY DAY DESC
LIMIT 30;