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

