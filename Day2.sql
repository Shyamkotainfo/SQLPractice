-- Challenge: WHERE
-- How many payment were made by the customer with customer_ID = 100?
SELECT
count(*)
FROM payment
WHERE customer_id = 100;

-- What is the last name of our customer with first name 'ERICA'?
SELECT
first_name, last_name
FROM customer
WHERE first_name = 'ERICA';

-- Challenge: WHERE Operators
-- The inventory manager asks you how many rentals have not been returned yet (return_date is null)
SELECT
COUNT(*)
FROM rental
WHERE return_date is null;

-- The sales_manager asks you how for a list of all the payment_ids with an amount 
-- less than or equal to $2. Include payment_id and the amount.
SELECT
payment_id,
amount
FROM payment
WHERE amount <= 2;

-- Challenge: WHERE with AND / OR
-- The support manager asks you a list of all the payment of the customer 
-- 322, 346 and 354 where the amount is either less than $2 or greater than $10.
-- It should be ordered by the customer first (ascending) and then as 
-- second condition order by the amount in a descending order.
SELECT
*
FROM payment
WHERE customer_id IN (322, 346, 354)
AND (amount < 2 OR amount > 10)
ORDER BY customer_id ASC, amount DESC;

-- Challenge: BETWEEN... AND...
-- There have been some faulty payments and you need to help to found out how many
-- payments have been affected.
-- How many payments have been made on January 26th and 27th 2020 with an amount between 1.99 and 3.99?
SELECT
COUNT (*)
FROM payment
WHERE payment_date BETWEEN '2020-01-26' AND '2020-01-28'
AND amount BETWEEN 1.99 AND 3.99;

-- Challenge: IN
-- There have been 6 complaints of custoemrs about their payments.
-- customer_id: 12, 25, 67, 93, 124, 234
-- The concerened payments are all the payments of these customers with
-- amounts 4.99, 7.99 and 9.99 in January 2020.
SELECT
*
FROM payment
WHERE customer_id IN (12, 25, 67, 93, 124, 234)
AND amount IN (4.99, 7.99, 9.99)
AND payment_date BETWEEN '2020-01-01' AND '2020-02-01';

-- Challenge: LIKE
-- You need to help the inventory manager to find out:
-- How many movies are there that contain the "Documentary" in the description?
SELECT
COUNT (*)
FROM film
WHERE description LIKE ('%Documentary%');

-- How many customers are there with a first name that is 3 letters long and 
-- either an 'X' or a 'Y' as the last letter in the last name?
SELECT
COUNT (*)
FROM customer
WHERE first_name LIKE ('___')
AND (last_name LIKE '%X' OR last_name LIKE '%Y');


-- Challenge: For Today
-- 1) How many movies are that contain 'Saga' in the description and where the title
-- starts either with 'A' or ends with 'R'? Use the alias 'no_of_movies'.
SELECT
COUNT (*) AS no_of_movies
FROM film
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%' OR title LIKE '%R');

-- 2) Create a list of all customers where the first name contains 'ER'
-- and has an 'A' as the second letter. Order the results by the last name descendingly.
SELECT
*
FROM customer
WHERE first_name LIKE '%ER%' AND first_name LIKE '_A%'
ORDER BY last_name DESC;

-- 3) How many payments are there where the amount is either 0 or is between
-- 3.99 and 7.99 and in the same time has happened on 2020-05-01.
SELECT
COUNT (*)
FROM payment
WHERE (amount = 0
OR amount BETWEEN 3.99 AND 7.99)
AND payment_date BETWEEN '2020-05-01' AND '2020-05-02';
