<!-- Recall Notes -->
I figure out the written order of SQL is different from it's execution for example;
Written order of INNER JOIN -> SELECT -> FROM -> JOIN -> ON -> ORDER BY
Execution order of INNER JOIN -> FROM -> JOIN -> ON -> SELECT -> ORDER BY

Error i got + how i fixed it;
1. I tried to order by the group by col but i still had repeated values in the result set, so i had to order by the aggregated col

2. I tried to restore a created (new database) named 'dvdrental' by gping to tools -> restore, but it didn't work; so i had to go to bin, copied the path and opened it in cmd - then i ran 'pg_restore -u postgres -d dvdrental 'file path' but didn't work. I now used '.\pg_restore -U (capital letter), inputed my password and it worked.
