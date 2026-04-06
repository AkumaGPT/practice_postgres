<!-- Recall Notes -->

When sorting (ORDER BY) during windows function, it's best to sort on both windows function section + sql written order section because they are independant of each other e.g, ROW_NUMBER() OVER (ORDER BY..DESC) FROm.. ORDER BY..DESC

Error i got + how i fixed it;

Group by expects all non-aggregated columns - I tried to retrieve/group by payment_date col which is a timestamp that returns both date and time as different rows. So i used DATE(payment_date) tthat keeps only the day/date and removes the time.

I selected/retrieve with distinct + grouped by which wasn't necessary because group by removes duplicates by grouping already.

It isn't necessary grouping by a col when there is no aggregation done, therefore sorting by col is enough.

In CASE, I always made a mistake of ending as 'spend' as a string instead of no string attached to make it a new col

Running totals + Moving Average goes forward in time therefore sorting by DESC is not necessary.