-- Challenge: Aggregate functions
-- Your manager wants to get a better understanding of the films.
-- That's why you are asked to write a query to see the -Minimum, -Maximum, -Average (rounded), -Sum of the replacement cost of the films.
SELECT 
MIN (replacement_cost),
MAX (replacement_cost),
ROUND (AVG(replacement_cost), 2) AS AVG,
SUM (replacement_cost)
FROM film;

-- Challenge: GROUP BY
-- Your manager wants to whi of the two employees (staff_id) is reponsible for more payments?
-- Which of the two is responsible for a higher overall payment amount?
SELECT
staff_id,
SUM (amount),
COUNT (*)
FROM payment
GROUP BY staff_id
ORDER BY SUM(amount) DESC;

-- How do these amounts change if we don't consider amounts equal to 0?
SELECT
staff_id,
SUM (amount),
COUNT (*)
FROM payment
WHERE amount != 0
GROUP BY staff_id
ORDER BY SUM(amount) DESC;

-- Challenge: GROUP BY multiple colums
-- There are two competitions the two employess.
-- Which employee had the highest sales amount in a single day?
SELECT 
staff_id,
DATE (payment_date),
SUM (amount),
COUNT (*)
FROM payment
GROUP BY staff_id, DATE(payment_date)
ORDER BY COUNT(*) DESC;

-- Whihc employee had the most sales in a single day (not counting payments with amount = 0)?
SELECT 
staff_id,
DATE (payment_date),
SUM (amount),
COUNT (*)
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY COUNT(*) DESC;

-- Challenge: HAVING
-- In 2020, April 28, 29 and 30 were days with very high revenue. That's why we want
-- to foucs in this task only on these days (filter accordingly).
-- Find our what is the average payment amount grouped by customer and day - consider
-- only the days/customers with more than 1 payment (per customer and day).
-- Order by the average amount in a descending order.
SELECT
customer_id,
DATE(payment_date),
COUNT(payment_id),
ROUND(AVG(amount), 2) AS AVG
FROM payment
WHERE DATE(payment_date) BETWEEN '2020-04-28' AND '2020-04-30 23:59'
GROUP BY customer_id, DATE(payment_date) HAVING COUNT(payment_id) > 1
ORDER BY AVG DESC;
