-- User defined functions
CREATE FUNCTION count_rr (min_r decimal(4, 2),
						 max_r decimal(4,2))
RETURNS INT
LANGUAGE plpgsql

AS
$$
DECLARE
movie_count INT;
BEGIN
SELECT COUNT(*)
FROM film
WHERE rental_rate BETWEEN min_r AND max_r;
RETURN movie_count;
END;
$$

-- Create a function that expects the customer's first and last name and returns
-- the total amount of payments this customer has made.
CREATE FUNCTION name_search(fname text, lname text)
RETURNS decimal(5, 2)
LANGUAGE plpgsql

AS
$$
DECLARE
tamount decimal(5,2);
BEGIN

SELECT SUM(amount) FROM payment a 
LEFT JOIN customer b
ON a.customer_id = b.customer_id
WHERE b.first_name = fname AND b.last_name = lname;

RETURN tamount;
END;
$$

-- Transactions
SELECT * FROM acc_balance;
BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE id=1;
UPDATE acc_balance
SET amount = amount + 100
WHERE id=2;
COMMIT;

-- The two employees Miller and christalle have agreeed to swap their positions
-- incl. their salary
SELECT * FROM employees
ORDER BY emp_id;

BEGIN;
UPDATE employees
SET position_title = 'Head of Sales'
WHERE emp_id = 2;
UPDATE employees 
SET position_title = 'Head of BI'
WHERE emp_id = 3;
UPDATE employees
SET salary = 12587.00
WHERE emp_id = 2;
UPDATE employees
SET salary = 14614.00
WHERE emp_id = 3;
COMMIT;

-- Rollbacks
BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE id=2;
UPDATE acc_balance
SET amount = amount + 100
WHERE id=1;
ROLLBACK;
COMMIT;

-- Stored Procedures
CREATE PROCEDURE sp_transfer
(tr_amount INT, sender INT, recipient INT)
LANGUAGE plpgsql

AS
$$
BEGIN
-- subtract from sender's balance
UPDATE acc_balance
SET amount = amount - tr_amount
WHERE id = sender;

-- add to recipient's balance
UPDATE acc_balance
SET amount = amount + tr_amount
WHERE id = recipient;
COMMIT;
END;
$$
CALL sp_transfer(500, 1, 2)

seLECT * FROM acc_balance

-- Create a stored procedure called emp_swap that accepts two parameters emp1 and 
-- emp2 as input and swaps the two employees position and salary. 
-- Test the stored procedure with emp_id 2 and 3.


CREATE PROCEDURE emp_swap(emp1 INT, emp2 INT)
LANGUAGE plpgsql

AS
$$
DECLARE
salary1 DEC(8, 2);
salary2 DEC(8,2);

position1 TEXT;
position2 TEXT;
BEGIN

--store values in variable
SELECT salary 
INTO salary1
FROM employees
WHERE emp_id = 5;

SELECT salary 
INTO salary2
FROM employees
WHERE emp_id = 6;

SELECT position_title 
INTO position1
FROM employees
WHERE emp_id = 5;

SELECT position_title 
INTO position2
FROM employees
WHERE emp_id = 6;

-- update salary
UPDATE employees
SET salary = salary2
WHERE emp_id = 5;

UPDATE employees
SET salary = salary1
WHERE emp_id = 6;

UPDATE employees
SET position_title = position2
WHERE emp_id = 5;

UPDATE employees
SET position_title = position1
WHERE emp_id = 6;

COMMIT;
END;
$$

SELECT * FROM employees

CALL emp_swap(5, 6)
