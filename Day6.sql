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

