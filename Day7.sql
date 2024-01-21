-- Challenge: Subqueries in WHERE
-- Select all of the films where the length is longer than the average of all films.
SELECT
*
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Return all the films that are available in the inventory in store 2 more than 3 times.
SELECT
*
FROM film
WHERE film_id IN (SELECT 
				  film_id FROM inventory
				 WHERE store_id = 2
				 GROUP BY film_id HAVING 
				 COUNT(store_id) > 3);

-- Return all customers first names and last names that have made a payment on
-- '2020-01-25'
SELECT
first_name, last_name
FROM customer
WHERE customer_id IN
(SELECT customer_id
FROM payment
WHERE DATE(payment_date) = '2020-01-25');

-- Return all customers first_names and email addresses that have spent a more than $30
SELECT 
first_name, email
FROM customer
WHERE customer_id IN
(SELECT
customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 30);

-- Return all the customers first and last names that are from California and 
-- have spent more than 100 in total
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 100)
AND customer_id IN (
	SELECT customer_id FROM customer a
	INNER JOIN address b
	ON a.address_id = b.address_id
	WHERE district = 'California')
ORDER BY first_name;

-- Challenge: Subqueries in FROM
-- What is the average total amount spent per day (average daily revenue)?
SELECT
ROUND(AVG(total_amount), 2) as avg_per_day
FROM
(
SELECT DATE(payment_date),
SUM(amount) as total_amount
FROM payment
GROUP BY DATE(payment_date)
);

-- Challenge: Subqueries in SELECT
-- Show all the payments together with how much the payment amount is below
-- the maximum payment amount
SELECT
*, (
SELECT
MAX(amount)
FROM payment
) - amount as difference
FROM payment;

-- Correlations subqueries in WHERE
-- Show only those movie titles, their associate film_id and replacement_cost
-- with the lowest replacement_costs for in each rating category - also show the rating
