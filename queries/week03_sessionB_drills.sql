-- Lab task 1 - rank paymenta
SELECT payment_id, customer_id, amount,
	RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rnk
FROM payment
LIMIT 10;