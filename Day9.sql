-- Challenge: ALTER TABLE
-- 1. director_account_name to VARCHAR(30)
-- 2. drop the default on last_name
-- 3. add the constraint not null to last name
-- 4. add the column email of data type VARCHAR(40)
-- 5. rename the director_account_bname to account_name
-- 6. rename the table from director to directors
ALTER TABLE director
ALTER COLUMN director_account_name TYPE VARCHAR(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD COLUMN IF NOT EXISTS email VARCHAR(40)

ALTER TABLE director
RENAME director_account_name to account_name

ALTER TABLE director
RENAME TO directors;

-- DROP & TRUNCATE
-- create table
CREATE TABLE emp_table
( emp_id SERIAL PRIMARY KEY,
 emp_name TEXT
)


-- select table
SELECT * FROM emp_table

-- Drop table
DROP TABLE emp_table

-- Insert values
INSERT INTO emp_table
VALUES
(1, 'Frank'),
(2, 'Maria')

-- Truncate table

TRUNCATE TABLE emp_table

-- Challenge: CHECK
-- 1. During creation add the DEFAULT 'Not defined' to the genre.
-- 2. Add the not null constraint to the song_name column
-- 3. Add the constraint with default name to ensure the price is at least 1.99.
-- 4. Add the constraint date_check to ensure the release date is between today and 01-01-1950
-- 5. Try insert a row like this:
-- 6. Modify the constraint to be able to have 0.99 allowed as the lowest possible price.

CREATE TABLE songs(
	song_id SERIAL PRIMARY KEY,
	song_name VARCHAR(30) NOT NULL,
	genre VARCHAR(30) DEFAULT 'Not Defined',
	price numeric(4, 2) CHECK (price >= 1.99),
	release_date DATE CONSTRAINT date_check
	CHECK (release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
)
INSERT INTO songs (song_name, price, release_date)
VALUES ('SQL song', '0.99', '01-07-2022')

ALTER TABLE songs
DROP CONSTRAINT songs_price_check;

ALTER TABLE songs
ADD CONSTRAINT songs_price_check CHECK(price >= 0.99)
