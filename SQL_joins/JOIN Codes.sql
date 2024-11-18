'Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. 
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.'

SELECT primary_poc, channel, name, orders.occurred_at
from web_events
join accounts
on web_events.account_id = accounts.id
join orders
on orders.account_id = accounts.id
where name = 'Walmart'
----------------------------------------------------------------------------------------------------------------------------
'Provide a table that provides the region for each sales_rep along with their associated accounts. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.'
  
select region.name, sales_reps.name, accounts.name
from sales_reps 
join region
on sales_reps.region_id = region.id
join accounts 
on accounts.sales_rep_id = sales_reps.id
order by accounts.name

-----------------------------------------------------------------------------------------------------------------------------

'Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, 
so I divided by (total + 0.01) to assure not dividing by zero.'

select region.name, accounts.name, orders.total_amt_usd/(total+0.01) as unit_price 
from region
join sales_reps
on sales_reps.region_id = region.id
join accounts
on accounts.sales_rep_id = sales_reps.id
join orders
----------------------------------------------------------------------------------------------------------------------------
'Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, 
and the account name. Sort the accounts alphabetically (A-Z) according to account name.'

SELECT region.name as regionname, sales_reps.name as salesname, accounts.name as accountname
FROM sales_reps
JOIN region 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest'
ORDER BY accounts.name;
------------------------------------------------------------------------------------------------------------------------------
'Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.'

SELECT region.name as regionname, sales_reps.name as salesname, accounts.name as accountname
FROM sales_reps
JOIN region 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest'
AND sales_reps.name LIKE 'S%'
ORDER BY accounts.name;
-------------------------------------------------------------------------------------------------------------------------------
'Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.'

SELECT region.name as regionname, sales_reps.name as salesname, accounts.name as accountname
FROM sales_reps
JOIN region 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest'
AND sales_reps.name LIKE '% K%'
ORDER BY accounts.name;
-------------------------------------------------------------------------------------------------------------------------------
'Provide the name for each region for every order, as well as the account name and 
the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price.'

SELECT region.name AS regionname, 
orders.total_amt_usd/(orders.total+0.01) AS unitprice, 
accounts.name AS accountsname
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
JOIN orders
ON orders.account_id = accounts.id
WHERE orders.standard_qty > 100
-------------------------------------------------------------------------------------------------------------------------------
'Provide the name for each region for every order, as well as the account name 
and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 
and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the smallest unit price first.'

SELECT region.name AS regionname, 
orders.total_amt_usd/(orders.total+0.01) AS unitprice, 
accounts.name AS accountsname
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON  accounts.sales_rep_id = sales_reps.id
JOIN orders
ON orders.account_id = accounts.id
WHERE orders.standard_qty > 100
AND orders.poster_qty >50
ORDER BY unitprice 
------------------------------------------------------------------------------------------------------------------------------ZCXselect region.name as regionname, 
'Provide the name for each region for every order, as well as the account name 
and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100 
and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. 
Sort for the largest unit price first.'

SELECT region.name AS regionname, 
orders.total_amt_usd/(orders.total+0.01) AS unitprice, 
accounts.name AS accountsname
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON  accounts.sales_rep_id = sales_reps.id
JOIN orders
ON orders.account_id = accounts.id
WHERE orders.standard_qty > 100
AND orders.poster_qty >50
ORDER BY unitprice DESC
-----------------------------------------------------------------------------------------------------------------------------------
'What are the different channels used by account id 1001? 
Your final table should have only 2 columns: account name and the different channels. 
You can try SELECT DISTINCT to narrow down the results to only the unique values.'

SELECT DISTINCT accounts.name, web_events.channel
FROM accounts 
JOIN web_events 
ON accounts.id = web_events.account_id
WHERE accounts.id = '1001'
-------------------------------------------------------------------------------------------------------------------------------
'Find all the orders that occurred in 2015. 
Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.'

SELECT orders.occurred_at, accounts.name, orders.total, orders.total_amt_usd
FROM accounts
JOIN orders
ON orders.account_id = accounts.id
WHERE orders.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY orders.occurred_at DESC;
--------------------------------------------------------------------------------------------------------------------------------










