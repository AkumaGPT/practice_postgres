-- KPI: total rentals
SELECT COUNT(*) AS total_rentals FROM rental;

-- KPI: total customers
SELECT COUNT(*) AS total_customers FROM customer;

-- KPI: total films
SELECT COUNT(*) AS total_films FROM film;

-- Daily payments count last 14 days
SELECT DATE(payment_date) AS DAY, COUNT(*) AS payment_count
FROM payment
GROUP BY DATE(payment_date)
ORDER BY DAY DESC
LIMIT 14;

-- Daily revenue last 14 days
SELECT DATE(payment_date) AS DAY, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DATE(payment_date)
ORDER BY DAY DESC
LIMIT 14;

--Monthly revenue all months
SELECT DATE_TRUNC('month', payment_date) AS month, SUM(amount) AS monthly_revenue
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY month DESC;

-- Top 10 customers by payments_count (join optional)
WITH total AS (
	SELECT customer_id, COUNT(*) AS payments_count
	FROM payment
	GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, payments_count
FROM total t
JOIN customer c
ON t.customer_id = c.customer_id 
ORDER BY payments_count DESC
LIMIT 10;

-- Top 10 customers by total_spent (with names)
WITH total AS (
	SELECT customer_id, SUM(amount) AS total_spent
	FROM payment
	GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, total_spent
FROM total t
JOIN customer c
ON t.customer_id = c.customer_id 
ORDER BY total_spent DESC
LIMIT 10;

-- Top 10 films by rentals_count
SELECT f.film_id, f.title, COUNT(*) AS rentals_count
FROM rental r
JOIN inventory i
ON i.inventory_id = r.inventory_id 
JOIN film f 
ON f.film_id = i.film_id 
GROUP BY f.film_id, f.title
ORDER BY rentals_count DESC
LIMIT 10;

-- Top 10 categories by rentals_count (category join path)
SELECT c.name, COUNT(*) AS rentals_count
FROM rental r
JOIN inventory i
ON i.inventory_id = r.inventory_id 
JOIN film f 
ON f.film_id = i.film_id 
JOIN film_category fc 
ON fc.film_id = f.film_id 
JOIN category c 
ON c.category_id = fc.category_id 
GROUP BY c.name
ORDER BY rentals_count DESC
LIMIT 10;

-- Top 10 staff by revenue collected
SELECT staff_id, SUM(amount) AS top_revenue
FROM payment
GROUP BY staff_id
ORDER BY top_revenue DESC
LIMIT 10;
	
	
-- Top 5 stores by revenue
SELECT c.store_id, SUM(amount) AS store_revenue
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id 
GROUP BY c.store_id
ORDER BY store_revenue DESC
LIMIT 5;
