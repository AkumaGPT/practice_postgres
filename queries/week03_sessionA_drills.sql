-- lab task 1
SELECT film_id, title, rental_rate,
CASE
	WHEN rental_rate < 2 THEN 'cheap'
	WHEN rental_rate < 4 THEN 'mid'
	ELSE 'premium'
END AS price_bucket
FROM film
ORDER BY rental_rate DESC 
LIMIT 5;

-- lab task 2
SELECT address_id, address,
	COALESCE(address2, '(none)') AS address2_clean
FROM address
LIMIT 20;

-- lab task 3
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC
LIMIT 20;

-- lab task 4
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