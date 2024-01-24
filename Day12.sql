-- Challenge: GROUPING SETS
-- Write a query that return the sum of the amount for each customer(first name
-- and last name) and each staff_id. Also add the overall revenue per customer.
SELECT
first_name,
last_name,
staff_id,
SUM(amount)

FROM payment a
LEFT JOIN customer b
ON a.customer_id = b.customer_id
GROUP BY
	GROUPING SETS (
	(first_name, last_name),
(first_name, last_name, staff_id))
ORDER BY first_name, last_name, staff_id

-- Write a query that caluculates now the share of revneue each staff_id makes per customer.
SELECT
first_name,
last_name,
staff_id,
SUM(amount) as total, 

ROUND((SUM(amount) / FIRST_VALUE(SUM(amount)) OVER(PARTITION BY first_name, last_name
							 ORDER BY SUM(amount) DESC)) * 100, 2)

FROM payment a
LEFT JOIN customer b
ON a.customer_id = b.customer_id
GROUP BY
	GROUPING SETS (
	(first_name, last_name),
(first_name, last_name, staff_id))
ORDER BY first_name, last_name, total DESC;

--Challenge: ROLLUP
SELECT 
'Q' || TO_CHAR(payment_date, 'Q') as quarter,
EXTRACT(month from payment_date) as month,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
ROLLUP('Q' || TO_CHAR(payment_date, 'Q'),
EXTRACT(month from payment_date),
DATE(payment_date))

ORDER BY 1, 2, 3;

-- Write a query that calcualtes a booking amount rollup for the hierarchy of 
-- quarter, month, week in month and day.
SELECT 
'Q' || TO_CHAR(book_date,'Q') as quarter,
EXTRACT(month from book_date) as month,
TO_CHAR(book_date, 'W')as week_in_month,
DATE(book_date) as day,
SUM(total_amount) as booking_amount
FROM bookings
GROUP BY
ROLLUP('Q' || TO_CHAR(book_date,'Q'),
EXTRACT(month from book_date),
TO_CHAR(book_date, 'W'),
DATE(book_date)
)
ORDER BY 1, 2, 3, 4;

-- Challenge: CUBE
SELECT customer_id, 
staff_id,
DATE(payment_date),
SUM(amount)

FROM payment
GROUP BY
CUBE(customer_id, 
staff_id,
DATE(payment_date)
)
ORDER BY 1, 2, 3

-- Write a query that returns all grouping sets in all combinations of customer_id, date and title with the aggregation of the payment amount.
-- The desired result looks like this:
-- How do you order the output to get that desired result?

SELECT
a.customer_id, DATE(payment_date), title,
SUM(amount) as total
FROM payment a
LEFT JOIN rental b
ON a.rental_id = b.rental_id
LEFT JOIN inventory c
ON b.inventory_id = c.inventory_id
LEFT JOIN film d
ON c.film_id = d.film_id

GROUP BY
CUBE(a.customer_id, DATE(payment_date), title
)
ORDER BY 1, 2, 3;

-- Challenge: self-joins
SELECT 
emp.employee_id,
emp.name as employee,
mng.name as manager
FROM employee emp
LEFT JOIN employee mng
ON emp.manager_id = mng.employee_id;

-- Find all the pairs of films with the same length
-- Order descendingly
SELECT 
f1.title, f2.title, f2.length
FROM film f1
LEFT JOIN film f2
ON f1.length = f2.length
WHERE f1.title != f2.title
ORDER BY length DESC

-- CROSS JOIN
SELECT 
f1.title, f2.title, f2.length
FROM film f1
LEFT JOIN film f2
ON f1.length = f2.length
WHERE f1.title != f2.title
ORDER BY length DESC;

-- NATURAL JOIN
SELECT
first_name, last_name
, SUM(amount)
FROM payment
NATURAL LEFT JOIN customer
GROUP BY first_name, last_name;

