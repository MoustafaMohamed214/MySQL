'1. Find the sales in terms of total dollars for all orders in each year, 
ordered from greatest to least.'

  SELECT DATE_TRUNC('year', occurred_at) AS ord_year, SUM(total_amt_usd) AS total_spent
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC

  'DATE_PART can also be used'
------------------------------------------------------------------------------------------------------

'2. Which month did Parch & Posey have the greatest sales in terms of total dollars?'

  SELECT DATE_TRUNC('month', occurred_at) AS ord_month, SUM(total_amt_usd) AS total_spent 
  FROM orders
  WHERE occurret_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP BY 1
  ORDER BY 2 DESC 
  
  'DATE_PART can also be used'
-----------------------------------------------------------------------------------------------------

'3. Which year did Parch & Posey have the greatest sales in terms of total number of orders?'

  SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(total) AS total_sales
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC


'4. Which month did Parch & Posey have the greatest sales in terms of total number of orders? '

  SELECT DATE_PART('month', occurred_at) ord_month,  COUNT(total) AS total_sales
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC


'5. In which month of which year did "Walmart" spend the most on gloss paper in terms of dollars?'

  SELECT DATE_TRUNC('month', orders.occurred_at) ord_date,  
  SUM(orders.gloss_amt_usd) AS total_gloss_usd
  FROM orders
  JOIN accounts
  ON accounts.id = orders.account.id
  WHERE accounts.name = 'Walmart'
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1
