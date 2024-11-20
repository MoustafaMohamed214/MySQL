"GROUP BY"
1. 'Which account (by name) placed the earliest order? Your solution should have 
the account name and the date of the order.'

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
ORDER BY occurred_at
LIMIT 1
  
2. 'Find the total sales in usd for each account. You should include two columns - 
the total sales for each companys orders in usd 
and the company name.'

SELECT SUM(orders.total_amt_usd), accounts.name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY accounts.name 
  
3. 'Via what channel did the most recent (latest) web_event occur, 
which account was associated with this web_event? 
Your query should return only three values - the date, channel, and account name.'

SELECT web_event.channel, web_events.occurred_at, accounts.name
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
ORDER BY web_events.occurred_at DESC
LIMIT 1

4. 'Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - 
the channel and the number of times the channel was used.'

SELECT channel, COUNT(channel) AS number_of_times
FROM web_events
GROUP BY channel

5. 'Who was the primary contact associated with the earliest web_event?'

SELECT accounts.primary_poc
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id 
ORDER BY web_events.occurred_at
LIMIT 1

6. 'What was the smallest order placed by each account in terms of total usd. 
Provide only two columns - the account name and the total usd. 
Order from smallest dollar amounts to largest.'

SELECT MIN(orders.total_amt_usd) AS smallest_order, accounts.name
FROM orders
JOIN accoounts
ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY smallest_order

7. 'Find the number of sales reps in each region. 
Your final table should have two columns - the region and the number of sales_reps. 
Order from fewest reps to most reps.'

SELECT region.name, COUNT(sales_reps.name) AS number_sales_reps
FROM sales_reps
JOIN region
ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY number_sales_reps

8. 'For each account, determine the average amount of each type of paper they purchased 
across their orders. Your result should have four columns - one for the account name 
and one for the average quantity purchased for each of the paper types for each account.'

SELECT accounts.name, 
  AVG(orders.standard_qty) AS average_standard, 
  AVG(orders.poster_qty) AS average_poster,
  AVG(orders.gloss_qty) AS average_gloss
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY accounts.name

9. 'For each account, determine the average amount spent per order on each paper type. 
Your result should have four columns - one for the account name and one for the average 
amount spent on each paper type.'

SELECT accounts.name, 
  AVG(orders.standard_amt_usd) AS average_standard_usd, 
  AVG(orders.poster_amt_usd) AS average_poster_usd,
  AVG(orders.gloss_amt_usd) AS average_gloss_usd
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY accounts.name

10. 'Determine the number of times a particular channel was used in the web_events 
table for each sales rep. Your final table should have three columns - the name 
of the sales rep, the channel, and the number of occurrences. Order your table 
with the highest number of occurrences first.'

SELECT sales_reps.name, web_events.channel, COUNT(*) AS num_events
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
JOIN sales_reps
ON sales_reps.id = accounts.sales_reps_id
GROUP BY sales_reps.name, web_events.channel
ORDER BY num_events DESC


11. 'Determine the number of times a particular channel was used in the web_events 
table for each region. Your final table should have three columns - the region name, 
the channel, and the number of occurrences. Order your table with the highest number 
of occurrences first.'

SELECT web_events.channel, region.name, COUNT(*) AS num_occurrences
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
JOIN sales_reps
ON sales_reps.id = accounts.sales_reps_id
JOIN region
ON sales_reps.region_id = region.id
GROUP BY web_events.channel, region.name
ORDER BY num_occurrences DESC

----------------------------------------------------------------------------------------------------------------
"DISTINCT"

'Use DISTINCT to test if there are any accounts associated with more than one region.'

//CODE 1//
SELECT accounts.id, region.id, 
accounts.name, region.name
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN region 
ON region.id = sales_reps.region_id;

//CODE 2//
SELECT DISTINCT id, name
FROM accounts;

--- Compare Between CODE 1 and CODE 2 ---
--- CODE 1 = CODE 2 = 351 ---
--- so every account is associated with one region ---



'Have any sales reps worked on more than one account?'

//CODE 1//
SELECT sales_reps.id, sales_reps.name, COUNT(*) AS num_accounts
FROM accounts 
JOIN sales_reps 
ON sales_reps.id = accounts.sales_rep_id
GROUP BY sales_reps.id, sales_reps.name
ORDER BY num_accounts;

//CODE 2//
SELECT DISTINCT id, name
FROM sales_reps;

--- all the sales reps worked on more than one account ---
--- Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query ---
--- both CODES give the same number of results = 50 ---
-------------------------------------------------------------------------------------------------------------------------
"HAVING"
'1. How many of the sales reps have more than 5 accounts that they manage?'
  SELECT sales_reps.id, sales_reps.name, COUNT(*) AS account_num
  FROM accounts
  JOIN sales_reps
  ON accounts.sales_rep_id = sales_reps.id
  GROUP BY sales_reps.id, sales_reps.name
  HAVING account_num > 5
  ORDER BY account_num

'2. How many accounts have more than 20 orders?'
  SELECT accounts.id, accounts.name, COUNT(*) AS orders_num
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  HAVING COUNT(*) > 20
  ORDER BY orders_num

'3. Which account has the most orders?'
  SELECT accounts.id, accounts.name, COUNT(*) AS orders_num
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  ORDER BY orders_num DESC
  LIMIT 1

'4. Which accounts spent more than 30,000 usd total across all orders?'
  SELECT accounts.id, accounts.name, SUM(orders.total_amt_usd) AS amount_spent
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  HAVING SUM(orders.total_amt_usd) > 30,000
  ORDER BY amount_spent


'5. Which accounts spent less than 1,000 usd total across all orders?'
  SELECT accounts.id, accounts.name, SUM(orders.total_amt_usd) AS amount_spent
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  HAVING SUM(orders.total_amt_usd) < 1,000
  ORDER BY amount_spent


'6. Which account has spent the most with us?'
  SELECT accounts.id, accounts.name, SUM(orders.total_amt_usd) AS amount_spent
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  ORDER BY amount_spent DESC
  LIMIT 1


'7. Which account has spent the least with us?'
  SELECT accounts.id, accounts.name, SUM(orders.total_amt_usd) AS amount_spent
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  ORDER BY amount_spent 
  LIMIT 1


'8. Which accounts used facebook as a channel to contact customers more than 6 times?'
  SELECT accounts.id, accounts.name, web_events.channel,
  COUNT(*) AS amount_contacted
  FROM web_events
  JOIN accounts
  ON web_events.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name
  HAVING COUNT(*) > 6 AND web_events.channel = 'facebook'
  ORDER BY amount_contacted


'9.Which account used facebook most as a channel?'
  SELECT accounts.id, accounts.name, web_events.channel,
  COUNT(*) AS amount_contacted
  FROM web_events
  JOIN accounts
  ON web_events.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name, web_events.channel
  HAVING web_events.channel = 'facebook'
  ORDER BY amount_contacted DESC
  LIMIT 1
  

'10.Which channel was most frequently used by most accounts?'
  SELECT accounts.id, accounts.name, web_events.channel,
  COUNT(*) AS most_freq_used
  FROM web_events
  JOIN accounts
  ON web_events.account_id = accounts.id 
  GROUP BY accounts.id, accounts.name, web_events.channel
  ORDER BY amount_contacted DESC
  LIMIT 105 --- the first 105 are all direct ---

