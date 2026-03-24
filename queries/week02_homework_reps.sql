-- check table names
SELECT table_name
FROM information_schema.TABLES
WHERE table_schema = 'public'
ORDER BY table_name;

-- distinct list of film rental rates
SELECT DISTINCT rental_rate
FROM film;

--distinct list OF customer last names (20)
SELECT DISTINCT last_name
FROM customer
LIMIT 20;

-- films with rating (PG-13, R) - title, rating (10)
SELECT title, rating
FROM film 
WHERE rating IN ('PG-13', 'R')
LIMIT 10;

--payments with amounts between 0.99 and 2.99 (10)
SELECT amount
FROM payment
WHERE amount BETWEEN 0.99 AND 2.99
LIMIT 10;

-- films that contain 'love' in the title
SELECT title
FROM film
WHERE title LIKE '%love%'
LIMIT 10;

-- films that contain 'man' in the title
SELECT title
FROM film
WHERE title LIKE '%man%'
LIMIT 10;

-- customers with first names that start with A
SELECT first_name
FROM customer
WHERE first_name LIKE 'A%'
LIMIT 10;

-- addresses where address2 is not null (10)
SELECT address2
FROM address 
WHERE address2 IS NOT NULL
LIMIT 10;

--films ordered by length desc (10)
SELECT title, length
FROM film 
ORDER BY length DESC
LIMIT 10;

--films ordered by length asc (10)
SELECT title, length
FROM film 
ORDER BY length ASC
LIMIT 10;

--order by film id offset 10 (10)
SELECT film_id, title
FROM film
ORDER BY film_id
LIMIT 5 OFFSET 10;

--order by film id offset 15 (10)
SELECT film_id, title
FROM film
ORDER BY film_id
LIMIT 5 OFFSET 15;

--payments ordered by amouunt desc (10)
SELECT amount
FROM payment
ORDER BY amount DESC 
LIMIT 10;

--payments ordered by amouunt asc (10)
SELECT amount
FROM payment
ORDER BY amount ASC  
LIMIT 10;

-- rentals ordered by rental_date desc (10)
SELECT rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 10;

-- mini project
-- top 10 expensive payments
SELECT payment_id, customer_id, amount
FROM payment
ORDER BY amount DESC 
LIMIT 10

-- 10 most recent rentals
SELECT  rental_id, rental_date, customer_id
FROM rental
ORDER BY rental_date DESC
LIMIT 10;

''' session B '''

-- count total rents
SELECT count(*) FROM rental;

-- Count total payments
SELECT count(*) FROM payment;

-- Top 10 customers by number of payments (customer_id + COUNT)
SELECT customer_id, count(*) AS total_no_of_payments
FROM payment
GROUP BY customer_id 
ORDER BY total_no_of_payments DESC
LIMIT 10;

-- Top 10 customers by total spent (customer_id + SUM(amount))
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id 
ORDER BY total_spent DESC
LIMIT 10;

-- Same as #4 but include customer name (join)
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c
    ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Total revenue collected per staff_id (GROUP BY staff_id + SUM)
SELECT staff_id, SUM(amount) AS total_staff_revenue
FROM payment
GROUP BY staff_id
ORDER BY total_staff_revenue

-- Staff revenue but only staff with revenue > 3000 (HAVING)
SELECT staff_id, SUM(amount) AS total_staff_revenue
FROM payment
GROUP BY staff_id
HAVING SUM(amount) > 3000
ORDER BY total_staff_revenue

-- Payments per day: group by DATE(payment_date) and count (top 10 days by count)
SELECT DATE(payment_date) AS day, COUNT(*) AS payments_per_day
FROM payment
GROUP BY DATE(payment_date)
ORDER BY payments_per_day DESC
LIMIT 10;

-- Payments per day: group by DATE(payment_date) and sum (top 10 days by revenue)
SELECT DATE(payment_date) AS day, SUM(amount) AS daily_revenue
FROM payment
GROUP BY DATE(payment_date)
ORDER BY daily_revenue DESC
LIMIT 10;

-- 10 most recent rentals with film title (join path)
SELECT f.title, r.rental_date
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r 
	ON r.inventory_id = i.inventory_id 
ORDER BY r.rental_date DESC 
LIMIT 10;

-- 10 rentals for one customer_id of your choice (filter + join title)
SELECT r.customer_id, f.title, r.rental_date
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r 
	ON r.inventory_id = i.inventory_id 
WHERE r.customer_id = 2
GROUP BY r.customer_id, f.title, r.rental_date
--HAVING r.customer_id = 2
ORDER BY r.rental_date DESC 
LIMIT 10;

-- Customers who made more than 35 payments (HAVING COUNT(*) > 35)
SELECT customer_id, count(*) AS total_payment
FROM payment
GROUP BY customer_id 
HAVING count(*) > 35
ORDER BY total_payment DESC 
LIMIT 10;

-- Mini project: Daily revenue report
-- show day(payment date)
SELECT date(payment_date) FROM payment
LIMIT 4;

-- count payments
SELECT count(*) AS payments_count FROM payment;

-- daily revenue
SELECT payment_date, SUM(amount) AS daily_revenue
FROM payment
GROUP BY payment_date
ORDER BY daily_revenue DESC
LIMIT 14;

