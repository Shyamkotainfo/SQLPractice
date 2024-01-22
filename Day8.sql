-- Challenges: Mid course project
/*Question 1:

Level: Simple

Topic: DISTINCT

Task: Create a list of all the different (distinct) replacement costs of the films.

Question: What's the lowest replacement cost?

Answer: 9.99*/

SELECT DISTINCT
replacement_cost
FROM film;

SELECT DISTINCT
MIN(replacement_cost)
FROM film;


/*
Question 2:

Level: Moderate

Topic: CASE + GROUP BY

Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges

low: 9.99 - 19.99

medium: 20.00 - 24.99

high: 25.00 - 29.99

Question: How many films have a replacement cost in the "low" group?

Answer: 514
*/
SELECT
CASE
WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
ELSE 'invalid'
END
FROM film

SELECT
COUNT(replacement_cost),
CASE
WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
ELSE 'invalid'
END x
FROM film 
GROUP BY x
ORDER BY x DESC
LIMIT 1 OFFSET 1;
/*
Question 3:

Level: Moderate

Topic: JOIN

Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. Filter the results to only the movies in the category 'Drama' or 'Sports'.

Question: In which category is the longest film and how long is it?

Answer: Sports and 184
*/

SELECT 
title, length, name
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
LEFT JOIN category c
ON b.category_id = c.category_id
WHERE name IN ('Drama', 'Sports')
ORDER BY length DESC;

SELECT 
name, length
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
LEFT JOIN category c
ON b.category_id = c.category_id
WHERE name IN ('Drama', 'Sports')
ORDER BY length DESC
LIMIT 1;

/*
Question 4:

Level: Moderate

Topic: JOIN & GROUP BY

Task: Create an overview of how many movies (titles) there are in each category (name).

Question: Which category (name) is the most common among the films?

Answer: Sports with 74 titles
*/
SELECT 
name,
COUNT(title)
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
LEFT JOIN category c
ON b.category_id = c.category_id
GROUP BY name
ORDER BY 2 DESC
LIMIT 1;

/*
Question 5:

Level: Moderate

Topic: JOIN & GROUP BY

Task: Create an overview of the actors' first and last names and in how many movies they appear in.

Question: Which actor is part of most movies??

Answer: Susan Davis with 54 movies
*/
SELECT
first_name, last_name, COUNT(c.film_id)
FROM actor a
LEFT JOIN film_actor b
ON a.actor_id = b.actor_id
LEFT JOIN film c
ON b.film_id = c.film_id
GROUP BY first_name, last_name
ORDER BY 3 DESC
LIMIT 1;

/*
Question 6:

Level: Moderate

Topic: LEFT JOIN & FILTERING

Task: Create an overview of the addresses that are not associated to any customer.

Question: How many addresses are that?
Answer: 4
*/


/*
Question 7:

Level: Moderate

Topic: JOIN & GROUP BY

Task: Create the overview of the sales  to determine the from which city (we are interested in the city in which the customer lives, not where the store is) most sales occur.

Question: What city is that and how much is the amount?

Answer: Cape Coral with a total amount of 221.55
*/

/*
Question 8:

Level: Moderate to difficult

Topic: JOIN & GROUP BY

Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".

Question: Which country, city has the least sales?

Answer: United States, Tallahassee with a total amount of 50.85.
*/

/*
Question 9:

Level: Difficult

Topic: Uncorrelated subquery

Task: Create a list with the average of the sales amount each staff_id has per customer.

Question: Which staff_id makes on average more revenue per customer?

Answer: staff_id 2 with an average revenue of 56.64 per customer.
*/

/*
Question 10:

Level: Difficult to very difficult

Topic: EXTRACT + Uncorrelated subquery

Task: Create a query that shows average daily revenue of all Sundays.

Question: What is the daily average revenue of all Sundays?

Answer: 1410.65
*/

/*
Question 11:

Level: Difficult to very difficult

Topic: Correlated subquery

Task: Create a list of movies - with their length and their replacement cost - that are longer than the average length in each replacement cost group.

Question: Which two movies are the shortest on that list and how long are they?

Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.
*/

/*
Question 12:

Level: Very difficult

Topic: Uncorrelated subquery

Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.

Example:
If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 and the second customer has a total spent of $2000 then the "average customer lifetime spent" in this district is $1500.

So, first, you need to calculate the total per customer and then the average of these totals per district.

Question: Which district has the highest average customer lifetime value?

Answer: Saint-Denis with an average customer lifetime value of 216.54.
*/

/*
Question 13:

Level: Very difficult

Topic: Correlated query

Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) plus the total amount that was made in this category. Order the results ascendingly by the category (name) and as second order criterion by the payment_id ascendingly.

Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?

Answer: Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.
*/

/*
Bonus question 14:

Level: Extremely difficult

Topic: Correlated and uncorrelated subqueries (nested)

Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name).

Question: Which is the top-performing film in the animation category?

Answer: DOGMA FAMILY with 178.70.
*/
