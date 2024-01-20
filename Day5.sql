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

