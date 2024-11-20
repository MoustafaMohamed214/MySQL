'COUNT'
1.
SELECT COUNT(*)
FROM accounts

2.
SELECT COUNT(accounts.id)
FROM accounts;
---------------------------------------------------------------------------------------------------------------------------------
'SUM'
1. 'Find the total amount of poster_qty paper ordered in the orders table.'
SELECT SUM(poster_qty) AS Total_number_posters
  FROM orders
  
2. 'Find the total amount of standard_qty paper ordered in the orders table.'
SELECT SUM(standard_qty) AS Total_number_standard
  FROM orders
  
3. 'Find the total dollar amount of sales using the total_amt_usd in the orders table.'
SELECT SUM(total_amt_usd) AS Total_amount_sales
  FROM orders
  
4. 'Find the total amount for each individual order that was spent on standard and gloss paper in the orders table. 
This should give a dollar amount for each order in the table.'
SELECT SUM(standard_amt_usd) + SUM(gloss_amt_usd) AS Total_standard_gloss
  FROM orders

      "Solution Without Aggregations"
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders
  
5. 'Though the price/standard_qty paper varies from one order to the next. 
I would like this ratio across all of the sales made in the orders table.'

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS price_per_unit
FROM orders
------------------------------------------------------------------------------------------------------------------------
'MIN & MAX'
1. 'When was the earliest order ever placed? You only need to return the date.'

SELECT MIN(occurred_at) AS earliest_order
FROM orders

2. 'Try performing the same query as in question 1 without using an aggregation function.'

SELECT occurred_at AS earliest_order
FROM orders
ORDER BY occurred_at
LIMIT 1

3. 'When did the most recent (latest) web_event occur?'

SELECT MAX(occurred_at) AS latest_order
FROM web_events

4. 'Try to perform the result of the previous query without using an aggregation function.'

SELECT occurred_at AS latest_order
FROM web_events
ORDER BY occured_at DESC
LIMIT 1

5. 'Find the mean (AVERAGE) amount spent per order on each paper type, 
as well as the mean amount of each paper type purchased per order. 
Your final answer should have 6 values - one for each paper type for the average number of sales, 
as well as the average amount.'

SELECT AVG(standard_amt_usd) AS average_standard_usd
AVG(poster_amt_usd) AS average_poster_usd
AVG(gloss_amt_usd) AS average_gloss_usd
AVG(standard_qty) AS average_standard_qty
AVG(poster_qty) AS average_poster_qty
AVG(gloss_qty) AS average_gloss_qty
FROM orders

6.'Via the video, you might be interested in how to calculate the MEDIAN. 
Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? 
Note, this is more advanced than the topics we have covered thus far to build a general solution, 
but we can hard code a solution in the following way.'










  
