-- Challenge: INNER JOIN
-- The airline company wants to understand in which category they sell most tickets.
--  Business
--  Economy or
--  comfort?
-- You need to work on the seats table and the boarding_passes table.
SELECT fare_conditions,
COUNT (*)
FROM seats sa
INNER JOIN boarding_passes ba
ON sa.seat_no = ba.seat_no
GROUP BY fare_conditions;

-- Challenge: LEFT OUTER JOIN
-- The flight company is trying to find out  what their most popular seats are.
-- Try to find out which seat has been chosen most frequently. Make sure all seats
-- are included even if they have never been booked.
-- Are there seats that have never been booked?
SELECT 
a.seat_no,
COUNT (*)
FROM seats a
LEFT JOIN boarding_passes b
ON a.seat_no = b.seat_no
GROUP BY a.seat_no
ORDER BY COUNT (*) DESC;

-- Try to find out which line (A, B, ..., H) has been chose most frequently
SELECT 
RIGHT(a.seat_no, 1),
COUNT (*)
FROM seats a
LEFT JOIN boarding_passes b
ON a.seat_no = b.seat_no
GROUP BY RIGHT(a.seat_no, 1)
ORDER BY COUNT (*) DESC;

-- Challenge: Joins
-- The company wants to run a phone call campaing on all customers in Texas (=dostroct)
-- What are the customers (first_name, last_name, phone number and their district) from Texas?
SELECT first_name, last_name,
phone, district
FROM customer x
RIGHT JOIN address y
ON x.address_id = y.address_id
WHERE district = 'Texas';

-- Are there any (old addresses that are not related to any customer?
SELECT *
FROM address y
LEFT JOIN customer x
ON x.address_id = y.address_id
WHERE x.address_id is null;

-- Challenge: Join using multiple colums
SELECT 
seat_no,
ROUND(AVG (amount), 2)
FROM boarding_passes x
LEFT JOIN ticket_flights y
ON x.ticket_no = y.ticket_no
AND x.flight_id = y.flight_id
GROUP BY seat_no
ORDER BY 2 DESC;

-- Challenge: Joining multiple tables
-- The company wants customize their campaigns to customers depending on the country they are from.
-- Which customers are from Brazil?
-- Write a query to get first_name, last_name, email and the country from all customers from Brazil.
SELECT first_name, last_name, email, country FROM customer a
INNER JOIN address b
ON a.address_id = b.address_id
INNER JOIN city c
ON b.city_id = c.city_id
INNER JOIN country d
ON c.country_id = d.country_id
WHERE country = 'Brazil';

SELECT first_name, last_name, email, country FROM customer a
LEFT JOIN address b
ON a.address_id = b.address_id
LEFT JOIN city c
ON b.city_id = c.city_id
LEFT JOIN country d
ON c.country_id = d.country_id
WHERE country = 'Brazil';

-- Challenge:
-- 1) Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?
SELECT passenger_name, SUM(total_amount)
FROM tickets a
LEFT JOIN bookings b
ON a.book_ref = b.book_ref
GROUP BY passenger_name
ORDER BY 2 DESC
LIMIT 1;

-- 2) Which fare_condition has ALEKSANDR IVANOV used the most?
SELECT passenger_name, fare_conditions, COUNT(*)
FROM tickets a
LEFT JOIN ticket_flights b
ON a.ticket_no = b.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions, passenger_name
ORDER BY COUNT DESC
LIMIT 1;

-- Which title has GEORGE LINTON rented the most often?
SELECT first_name, last_name, title, COUNT(*) FROM customer a
INNER JOIN rental b
ON a.customer_id = b.customer_id
INNER JOIN inventory c
ON b.inventory_id = c.inventory_id
INNER JOIN film d
ON c.film_id = d.film_id
WHERE first_name = 'GEORGE' AND last_name = 'LINTON'
GROUP BY title, first_name, last_name
ORDER BY 4 DESC
LIMIT 1;
