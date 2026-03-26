-- CASE syntax
--CASE
--  WHEN condition THEN result
--  WHEN condition THEN result
--  ELSE result
--END

-- label films into price buckets
SELECT title, rental_rate,
	CASE
		WHEN rental_rate < 2 THEN 'cheap'
		WHEN rental_rate < 4 THEN 'mid'
		ELSE 'premium'
	END AS price_bucket
FROM film
ORDER BY rental_rate ASC 
LIMIT 20;

-- label payments as small vs big
SELECT payment_id, amount,
CASE 
	WHEN amount >= 5 THEN 'big'
	ELSE 'small'
END AS payment_size
FROM payment
ORDER BY amount DESC 
LIMIT 10;

-- COALESCE syntax - COALESCE(col, 'fallback')
SELECT address_id, address,
	COALESCE(address2, '(none)') AS address2_clean
FROM address
ORDER BY address_id
LIMIT 10;

SELECT customer_id,
    COALESCE(email, '(no_email)') AS email_clean
FROM customer
ORDER BY customer_id
LIMIT 10;

-- subquery syntax - SELECT .. FROM table WHERE col IN (SELECT ..); SELECT .. FROM (SELECT ...) AS sub;
-- Customers who have made at least one payment
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id FROM payment)
LIMIT 10;

-- Films with rental_rate above the average rental_rate
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate
LIMIT 10;

-- CTE (WITH ..) syntax - WITH name AS (SELECT ..) SELECT .. FROM name;
-- total spent per customer
WITH spend AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM spend
ORDER BY total_spent DESC
LIMIT 10;

-- add customer names in the final shape
WITH spend AS (
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, s.total_spent
FROM spend s
JOIN customer c
    ON s.customer_id = c.customer_id
ORDER BY s.total_spent DESC
LIMIT 10;

''' SESSION B READING'''
-- Window Funtion syntax -- FUNCTION(..) OVER (PARTITION BY.. ORDER BY ..)

-- Add a row number to payments (biggest payment first)
SELECT payment_id, customer_id, amount,
	ROW_NUMBER() OVER (ORDER BY amount DESC) AS rn
FROM payment
LIMIT 10;

-- Row number resets per customer (each customer's payments ranked)
SELECT payment_id, customer_id, amount,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
FROM payment
LIMIT 20;

--PARTITION syntax - .. OVER (PARTITION BY group_col ORDER BY sort_col)

-- Rank payments inside each customer
SELECT payment_id, customer_id, amount,
	RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS pay_rank
FROM payment
LIMIT 20;

-- ROW_NUMBER() syntax - ROW_NUMBER() OVER (PARTITION BY.. ORDER BY..)

-- Top 1 payment per customer
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

-- RANK() + DENSE_RANK() syntax - RANK() OVER (ORDER BY col DESC); DENSE_RANK() OVER (ORDER BY col DESC)
SELECT payment_id, amount,
	RANK() OVER (ORDER BY amount DESC) AS rnK,
	DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rnk
FROM payment
LIMIT 20;

-- Running total

--SUM(col) OVER (ORDER BY sort_col) AS total_running

-- Daily revenue + running revenue
WITH daily AS (
SELECT DATE(payment_date) AS day, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DATE(payment_date)
)
SELECT DAY, daily_revenue,
	SUM(daily_revenue) OVER (ORDER BY day) AS running_revenue
FROM daily
ORDER BY DAY
LIMIT 14;