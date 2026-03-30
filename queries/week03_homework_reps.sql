-- CASE practice
-- 1.	Film length bucket: < 60 = short, < 120 = medium, else long (show title, length, bucket, limit 20)
SELECT title, length,
CASE
	WHEN length < 60 THEN 'short'
	WHEN length < 120 THEN 'medium'
	ELSE 'long'
END AS length_bucket
FROM film
LIMIT 20;

-- 2.	Payment bucket: < 2 = low, < 5 = medium, else high (show payment_id, amount, bucket, limit 20)
SELECT payment_id, amount,
CASE 
	WHEN amount < 2 THEN 'low'
	WHEN amount < 5 THEN 'medium'
	ELSE 'high'
END AS payment_bucket
FROM payment
LIMIT 20;

-- COALESCE practice
-- Address2 clean with (none) (limit 20)
SELECT address_id, address,
	COALESCE(address2, '(none)') AS address2_clean
FROM address
LIMIT 20;

-- District clean with (no district) from address (limit 20)
SELECT address,
	COALESCE(district, '(no district)') AS district_clean
FROM address
LIMIT 20;

-- Subquery practice
-- Films with rental_rate greater than the average (limit 20)
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC
LIMIT 20;

-- Customers who appear in rental (use IN (SELECT DISTINCT ...)) (limit 20)
SELECT customer_id
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id FROM rental)
ORDER BY customer_id
LIMIT 10;

-- Customers who appear in payment (same idea) (limit 20)
SELECT customer_id
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id FROM payment)
LIMIT 20;

-- CTE practice
-- CTE: total payments count per customer, then join customer names (top 10)
WITH payment_count AS (
SELECT customer_id, COUNT(amount) AS payment_count
FROM payment
GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, p.payment_count
FROM customer c
JOIN payment_count p
    ON c.customer_id = p.customer_id
ORDER BY p.payment_count DESC 
LIMIT 10;

-- CTE: total spent per customer, then join customer names (top 10)
WITH total_spent AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, t.total_spent
FROM customer c
JOIN total_spent t
    ON c.customer_id = t.customer_id
ORDER BY t.total_spent DESC 
LIMIT 10;

-- CTE: daily revenue (DATE(payment_date)) with count + sum (top 14 days by date DESC)
WITH revenue_count AS (
SELECT DATE(payment_date) AS day, SUM(amount) AS daily_revenue, COUNT(amount) AS revenue_count
FROM payment
GROUP BY DATE(payment_date)
)
SELECT day, daily_revenue, revenue_count
FROM revenue_count
ORDER BY day DESC
LIMIT 14;

-- Mini report
WITH total_spent AS (
SELECT customer_id, SUM(amount) AS spent
FROM payment
GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, t.spent,
	CASE
		WHEN t.spent < 100 THEN 'Bronze'
		WHEN t.spent < 150 THEN 'Silver'
		ELSE 'Gold'
	END AS customer_tier
FROM customer c
JOIN total_spent t
    ON c.customer_id = t.customer_id
ORDER BY t.spent DESC 
LIMIT 20;

'''SESSION B'''

-- Add row numbers to payments ordered by payment_date DESC (limit 20)
SELECT payment_id, DATE(payment_date) AS DAY,
	ROW_NUMBER() OVER (ORDER BY DATE(payment_date) DESC) AS rn
FROM payment
LIMIT 20;

-- Add row numbers per customer ordered by payment_date DESC (limit 50)
SELECT payment_id, DATE(payment_date) AS DAY,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY DATE(payment_date) DESC) AS rn
FROM payment
LIMIT 50;