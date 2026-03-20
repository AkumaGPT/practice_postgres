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