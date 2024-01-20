-- Challenge: Mathematical functions and operators
-- Your manager is thinking about increasing the prices for films that are more
-- expensive to replace. For that reason, you should create a list of the films 
-- including the relation of rental rate / replacement cost where the rental rate is 
-- less than 4% of the replacement cost.
-- Create a list of that film_ids together with the percentage rounded to 2 decimal
-- places. For example 3.54 (=3.54%).
SELECT
film_id,
ROUND(rental_rate / replacement_cost*100,2) as percentage
FROM film
WHERE ROUND(rental_rate / replacement_cost*100,2) < 4
ORDER BY 2 ASC;

-- Challenge: CASE WHEN
SELECT
COUNT (*) AS flights,
CASE
WHEN actual_departure is null THEN 'no departure time'
WHEN actual_departure-scheduled_departure < '00:05' THEN 'On Time'
WHEN actual_departure-scheduled_departure < '01:00' THEN 'A Little bit Late'
ELSE 'Very Late'
END AS is_late
FROM flights
GROUP BY is_late;

-- You need to find out how many tickets you have sold in the following categoires:
--  Low price ticket: total_amount < 20,000
--  Mid price ticket: total_amount between 20,000 and 150,000
--  High price ticket: total_amount >= 150,000
-- How many high price tickets has the company sold?
SELECT
COUNT (*),
CASE
WHEN total_amount < 20000 THEN 'Low price ticket'
WHEN total_amount >= 20000 AND total_amount < 150000 THEN 'Mid price ticket'
WHEN total_amount >= 150000 THEN 'High price ticket'
ELSE 'Invalid ticket price'
END as ticket_price
FROM bookings
GROUP BY ticket_price;

-- You need to find out how many flights have departed in the following seasons:
--   Winter:  December, January, Februar
--   Spring: March, April, May
--   Summer: June, July, August
--   Fall: September, October, November
SELECT
COUNT (*) AS flights,
CASE
WHEN TO_CHAR(scheduled_departure, 'MM') IN ('12', '01', '02') THEN 'Winter'
WHEN TO_CHAR(scheduled_departure, 'MM') IN ('03', '04', '05') THEN 'Spring'
WHEN TO_CHAR(scheduled_departure, 'MM') IN ('06', '07', '08') THEN 'Summer'
ELSE 'Fall'
END AS season
FROM flights
GROUP BY season;

-- You want to create a tier list in the following way:
-- 1. Rating is 'PG' or 'PG-13' or length is more than 210 min: 'Greater rating or long (tier 1)
-- 2. Description contains 'Drama' and length is more than 90 min: 'Long drama (tier 2)
-- 3. Description contains 'Drama' and length is not more than 90 min: 'Short drama (tier3)'
-- 4. Rental_rate less than $1: 'very cheap (tier 4)'
-- If one movie can be in multiple categories it gets the higher tier assigned.
-- How can you filter to only those movies that apperar in one of these 4 tiers?
SELECT
title,
CASE
WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length > 90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' AND length <= 90 THEN 'Short drama (tier 3)'
WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
END AS tier
FROM film
WHERE
CASE
WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length > 90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' AND length <= 90 THEN 'Short drama (tier 3)'
WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
END
is not null;

-- Using CASE SUM
SELECT 
SUM(CASE
WHEN rating = 'G' THEN 1
ELSE 0
END) AS "G",
SUM(CASE
WHEN rating = 'R' THEN 1
ELSE 0
END) AS "R",
SUM(CASE
WHEN rating = 'NC-17' THEN 1
ELSE 0
END) AS "NC-17",
SUM(CASE
WHEN rating = 'PG-13' THEN 1
ELSE 0
END) AS "PG-13",
SUM(CASE
WHEN rating = 'PG' THEN 1
ELSE 0
END) AS "PG"
FROM film;

-- Challenge: COALESCE & CAST
SELECT
rental_date,
COALESCE(CAST(return_date AS varchar), 'not returned')
FROM rental
ORDER BY rental_date DESC;
