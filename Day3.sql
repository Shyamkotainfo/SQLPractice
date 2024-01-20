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
