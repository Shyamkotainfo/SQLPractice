-- Challenge: UPDATE
-- Update all rental prices that are 0.99 to 1.99
UPDATE film
SET rental_rate = 1.99
WHERE rental_rate = 0.99
-- The customer table needs to be altered as well:
-- 1. Add the column initials (data type varchar(10))
ALTER TABLE customer
ADD initials varchar(10)
-- 2. Update the values to the actual initials for example Frank Smith should be F.S.
UPDATE customer
SET initials = LEFT(first_name, 1) || '.' ||
				LEFT(last_name, 1) || '.'

-- Challenge: DELETE
-- Delete the rows in the payment table with payment_id 17064 and 17067
DELETE FROM payment
WHERE payment_id IN (17064, 17067)
RETURNING *

  -- CREATE TABLE AS
-- Create table 'customer_spendings' with first_name and last_name and total_amount
CREATE TABLE customer_spendings
AS 
SELECT first_name || ' ' || last_name as name, total_amount
FROM customer a
LEFT JOIN (
	SELECT customer_id, sum(amount) as total_amount FROM payment
GROUP BY customer_id
	) x
ON a.customer_id = x.customer_id


SELECT * FROM customer_spendings

-- Challenge: CREATE VIEW
-- Create a view called films_category that shows a list of the film titles including their title, length and category name ordered descendingly by the length.
-- Filter the results to only the movies in the category 'Action' and 'Comedy'.
CREATE VIEW films_category
AS

SELECT title, length, name
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
LEFT JOIN category c
ON b.category_id = c.category_id


SELECT * FROM films_category
WHERE name IN ('Action', 'Comedy');

-- Challenge: Managing views
-- In this challenge, we use again the view v_customer_info that we have previously created:
CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id
-- You need to perform the following tasks:

-- 1) Rename the view to v_customer_information.
ALTER VIEW v_customer_info 
RENAME TO v_customer_information
-- 2) Rename the customer_id column to c_id.
ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id
-- 3) Add also the initial column as the last column to the view by replacing the view.
CREATE OR REPLACE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country, cu.initials
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id
