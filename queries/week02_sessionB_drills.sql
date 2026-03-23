-- lab task 1
-- customer payments list
SELECT c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount, p.payment_date
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
ORDER BY p.payment_date DESC
LIMIT 10;

--lab task 2
-- Revenue per customer
SELECT c.customer_id, c.first_name, c.last_name, SUM(amount) AS total_spent
FROM customer c 
JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

--lab task 3
-- Big spenders > 150
SELECT c.customer_id, c.first_name, c.last_name, SUM(amount) AS total_spent
FROM customer c 
JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(amount) > 150
ORDER BY total_spent DESC
LIMIT 10;

--lab task 4
-- Recent Rentals With Film Titles
SELECT r.rental_id, r.rental_date, r.customer_id, f.title
FROM rental r
JOIN inventory i
    ON r.inventory_id  = i.inventory_id
JOIN film f
	ON i.film_id = f.film_id 
ORDER BY r.rental_date DESC 
LIMIT 4;