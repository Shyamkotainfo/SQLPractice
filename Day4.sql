-- Challenge: LENGTH, LOWER, UPPER
-- In the email system there was a problem with names where either the first name
-- or the last name is more than 10 characters long. Find these customers and 
-- output the list of these first and last names in all lowercase.
SELECT
LOWER(first_name),
LOWER(last_name),
LOWER(email)
FROM customer
WHERE LENGTH(first_name) > 10 OR LENGTH(last_name)>10;

-- Challenge LEFT & RIGHT
-- Extract the last 5 characters of the email address first.
-- The email address always ends with '.org'
SELECT
email,
RIGHT(email, 5)
FROM customer;

-- How can you extract just the dot'.' from the email address?
SELECT
email,
LEFT(RIGHT(email, 4), 1)
FROM customer;

-- Challenge: Concatenate
-- You need to create an anonymized version of the email addresses.
-- It should be the first character followed by '***' and then the last part 
-- starting with '@'. Note the email address always ends with '@sakilacustomer.org'.
SELECT
LEFT (email, 1) || '***' || RIGHT(email,19)
AS anonymized_email,
email
FROM customer;

-- Challenge: POSITION
-- In this challenge you have only the email address and the last name of the customers.
-- You need to extract the first name from the email address and concatenate it
-- with the last name. It should be in the form: "Last name, First name".
SELECT
last_name, email,
last_name || ', ' || LEFT(email, POSITION(last_name IN email)-2)
FROM customer;

-- Challenge: SUBSTRING
-- You need to create an anonymized form of the email addresses in the following way:
-- M***.S***@sakilacustomer.org
SELECT
SUBSTRING (email from POSITION(LEFT(first_name,1) IN email) for 1)
|| '***'
|| SUBSTRING (email from POSITION('.' IN email) for 2)
|| '***'
|| SUBSTRING (email from POSITION('@' IN email))
FROM customer;

-- In a second query create an anonymized form of the email addressess in the following way:
-- **Y.S**@sakilacustomer.org
SELECT
'***'
|| SUBSTRING (email from POSITION('.' IN email)-1 for 1)
|| SUBSTRING (email from POSITION('.' IN email) for 2)
|| '***'
|| SUBSTRING (email from POSITION('@' IN email))
FROM customer;

-- Challenge: EXTRACT
-- You need to analyze the payments and find out the following:
-- What's the monht with the highest total payment amount?
SELECT
EXTRACT (month from payment_date) AS Month,
SUM (amount),
COUNT (*)
FROM payment
GROUP BY EXTRACT (month from payment_date)
ORDER BY SUM (amount) DESC;

-- What's the day of week with the highest total payment amount(0 is Sunday)?
SELECT
EXTRACT (dow from payment_date) AS day_of_week,
SUM (amount),
COUNT (*)
FROM payment
GROUP BY EXTRACT (dow from payment_date)
ORDER BY SUM(amount) DESC;

-- What's the highest amount one customer has spent in a week?
SELECT
EXTRACT (week from payment_date) AS Week,
Customer_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY EXTRACT (week from payment_date), customer_id
ORDER BY SUM(amount) DESC;

-- Challenge: TO_CHAR
-- You need to sum payments and group in the following formats:
SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') AS day
FROM payment
GROUP BY 2
ORDER BY total_amount DESC;

SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Mon, YYYY') AS day
FROM payment
GROUP BY 2
ORDER BY total_amount DESC;

SELECT
SUM(amount) AS total_amount,
TO_CHAR(payment_date, 'Dy, HH:MI') AS day
FROM payment
GROUP BY 2
ORDER BY total_amount DESC;

-- Challenge: Intervals and Timestamps
-- You need to create a list for the support team of all rental durations
-- of customer with customer_id 35.
SELECT
EXTRACT (day from return_date-rental_date) * 24
+ EXTRACT (hour from return_date-rental_date) AS duration
FROM rental
WHERE customer_id = 35;

-- Also you need to find out for the support team which customer has the
-- average rental duration?
SELECT
AVG(return_date-rental_date) AS duration,
customer_id
FROM rental
GROUP BY customer_id
ORDER BY duration DESC;
