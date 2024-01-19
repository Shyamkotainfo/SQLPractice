-- Challenge: SELECT
-- The Marketing Manager asks you for a list of all customers.
-- With first name, last name and the customer's email address.

SELECT 
first_name, last_name, email
FROM customer

-- Challenge: ORDER BY
-- The Marketing Manager asks you to order the customer list by the last name.
-- They want to start from "Z" and work towards "A".
-- In case of the same last name the order should be based on the first name-
-- also from "Z" to "A".

SELECT 
first_name, last_name
FROM customer
ORDER BY last_name DESC, first_name DESC

SELECT 
first_name, last_name 
FROM customer
ORDER BY 2 DESC, 1 DESC -- 2: Second column, 1: first_colum in the query

-- Challenge: SELECT DISTINCT
-- A marketing team member asks you about the different prices that have been paid
-- To make it easier for them order the prices from high to low.

SELECT DISTINCT
amount
FROM payment
ORDER BY amount DESC

-- Challenge: For Today

-- 1) Create a list of all the distinct districts customers are from.
SELECT DISTINCT
district
FROM address

-- 2) What is the latest rental date?
SELECT
rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 10

-- 3) How many films does the company have?
SELECT 
COUNT(title)
FROM film

-- 4) How many distinct last names of the customers are there?
SELECT DISTINCT
COUNT(last_name)
FROM customer
