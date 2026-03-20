-- check tables
SELECT table_name
FROM information_schema.TABLES
WHERE table_schema = 'public'
ORDER BY table_name;

-- show 5 films - film_id, title, rating
SELECT film_id, title, rating
FROM film
ORDER BY film_id
LIMIT 5;

-- show all distinct ratings
SELECT DISTINCT rating
FROM film;

-- show 5 customers - customer_id, first_name, last_name
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id
LIMIT 5;

--find films where rating in (PG, G) (show 10 titles) 
SELECT title, rating
FROM film
WHERE rating IN ('PG', 'G')
LIMIT 10;

-- find films with rental rate between 2.99 and 4.99 (show title + rate)
SELECT title, rental_rate
FROM film 
WHERE rental_rate BETWEEN 2.99 AND 4.99
LIMIT 10;

-- find films where title starts with A (10)
SELECT title
FROM film
WHERE title LIKE 'A%'
LIMIT 10;

--find customers where last_name ends with 'son' (10)
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE '%son%'
LIMIT 10;

--shows addresses WHERE address2 IS NULL (5)
SELECT address, address2
FROM address
WHERE address2 IS NULL
LIMIT 5;

-- show films ordered by film_id - offset 0
SELECT film_id, title
FROM film
ORDER BY film_id OFFSET 0
LIMIT 10;

-- show films ordered by film_id - offset 5
SELECT film_id, title
FROM film
ORDER BY film_id OFFSET 5
LIMIT 10;