<!-- Recall Notes -->

SELECT retrieves data from a table in a database.

WHERE filters a row by a condition.

ORDER BY sorts result returned from the database.

LIMIT restricts how many rows are returned.

Error i got + how i fixed it;
1. I wrote ORDER BY ASC instead of ORDER BY col_name ASC.
2. Tried to filter a row given 2 conditions by using 2 WHERE, so i tried AND which now worked.