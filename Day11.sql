-- Challenge: OVER() with PARTITION BY
-- Write a query that returns the list of movies including
-- film_id, title, length, category, average length of movies in that category
-- Order the results by film_id
SELECT 
a.film_id, title, length, c.name,
ROUND(AVG(length) OVER(PARTITION BY c.name), 2)
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
LEFT JOIN category c
ON c.category_id = b.category_id

ORDER BY film_id;

-- Write a query that returns all payment details including 
-- the number of payments that were made by this customer and that amount
-- Order the results by payment_id
SELECT * ,
COUNT(*) OVER(PARTITION BY customer_id, amount)
FROM payment
ORDER BY payment_id ASC;

-- Challenge: OVER() with ORDER BY
-- Write a query that returns the running total of how late the flights are 
-- (difference between actual_arrival and scheduled arrival) ordered by flight_id
-- including the departure airport.
SELECT 
flight_id, departure_airport,
SUM(actual_arrival - scheduled_arrival)
OVER(ORDER BY flight_id, departure_airport)
FROM flights

-- As a second query, calculate the same running total but partition also by the departure airport
SELECT 
flight_id, departure_airport,
SUM(actual_arrival - scheduled_arrival)
OVER(PARTITION BY departure_airport ORDER BY flight_id, departure_airport)
FROM flights

-- Challenge: Rank()
-- Write a query that returns the customer's name, the country and how many payments they have.
-- Afterwards create a ranking of the top customers with most sales for each country.

-- Filter the results to only the top 3 customers per country.
SELECT * FROM
(
SELECT
b.first_name || ' ' || b.last_name as name,
e.country,
COUNT(*),
RANK() OVER(PARTITION BY e.country ORDER BY COUNT(*) DESC) as rank
FROM payment a
LEFT JOIN customer b
ON a.customer_id = b.customer_id
LEFT JOIN address c
ON b.address_id = c.address_id
LEFT JOIN city d
ON c.city_id = d.city_id
LEFT JOIN country e
ON d.country_id = e.country_id

GROUP BY name, e.country)
WHERE rank BETWEEN 1 AND 3;

-- Challenge: LEAD & LAg
-- Write a query that returns the revenue of the day and the revenue of the previous day.
SELECT 
SUM(amount),
DATE(payment_date),
LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)) as previous_day,
SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)) as difference
FROM payment
GROUP BY DATE(payment_date);
-- Afterwards calculate also the percentage growth compared to the previous day.
SELECT 
SUM(amount),
DATE(payment_date),
LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)) as previous_day,
SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)) as difference,
ROUND((SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)))
/ LAG(SUM(amount)) OVER (ORDER BY DATE(payment_date)) * 100 , 2) as growth
FROM payment
GROUP BY DATE(payment_date);
