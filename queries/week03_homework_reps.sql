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