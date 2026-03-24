<!-- Recall Notes -->

SELECT retrieves data from a table in a database.

WHERE filters a row by a condition.

ORDER BY sorts result returned from the database.

LIMIT restricts how many rows are returned.

Error i got + how i fixed it;
1. I wrote ORDER BY ASC instead of ORDER BY col_name ASC.
2. Tried to filter a row given 2 conditions by using 2 WHERE, so i tried AND which now worked.
3. I tried to group by a timestamp colum without using date(col) which returns same days as different rows
4. I retrieved a col using distinct + group by. Figured the distinct wasn't necessary bc group by doing it's job already
5. It wasn't necessary grouping by a col when there was no aggregation therefore, order by (sorting) by cols was enough.