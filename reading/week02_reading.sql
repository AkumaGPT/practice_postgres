CREATE DATABASE dvdrental;
SELECT current_database();

-- DiSTINCT syntax - SELECT DISTINCT col FROM table;
SELECT DISTINCT rating
FROM film;

SELECT DISTINCT city
FROM city
LIMIT 6;

-- IN syntax - WHERE col IN (value1, value2, value3)
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG')
LIMIT 6;

SELECT first_name, last_name
FROM actor
WHERE last_name IN ('Chase', 'Davis')
LIMIT 5;

-- BETWEEN syntax - WHERE col BETWEEN low AND high;

SELECT title, rating, rental_rate 
FROM film
WHERE rental_rate BETWEEN 2.99 AND 4.99
LIMIT 20;

SELECT payment_id, amount
FROM payment
WHERE amount BETWEEN 1 AND 3
LIMIT 10;

-- LIKE syntax - WHERE text_col AS 'A%'(starts with A), WHERE text_col AS %A% (contains A)
SELECT title
FROM film
WHERE title LIKE 'A%'
LIMIT 10;

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%son%'
LIMIT 10;

-- NULL syntax - WHERE col IS NULL, WHERE col IS NOT NULL
SELECT address_id, address2
FROM address
WHERE address2 IS NULL
LIMIT 10;

SELECT address_id, address2
FROM address
WHERE address2 IS NOT NULL 
LIMIT 10;

-- OFFSET syntax - ORRDER BY col LIMIT n OFFSET k;
SELECT film_id, title
FROM film
ORDER BY film_id
LIMIT 10 OFFSET 0;

SELECT film_id, title
FROM film
ORDER BY film_id
LIMIT 10 OFFSET 10;

'''session B reading'''

-- INNER JOIN
-- know the customers that paid for stuff
SELECT * FROM customer 
LIMIT 4;
SELECT * FROM payment
LIMIT 4;

SELECT  c.customer_id, c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
	ON c.customer_id = p.customer_id
LIMIT 10;

-- LEFT JOIN synatax - SELECT .. FROM a LEFT JOIN b ON a.key = b.key;
-- list customers and any payment
SELECT c.customer_id, c.first_name, SUM(p.amount) AS total_amount
FROM customer c
LEFT JOIN payment p
	ON p.customer_id = c.customer_id 
GROUP BY c.customer_id 
ORDER BY c.customer_id 
LIMIT 10;

