USE fintrack;

SELECT 
    account_type,
    COUNT(*) AS account_count,
    SUM(balance) as total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

SELECT
    customer_id,
    COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id;

SELECT 
    transaction_type,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY transaction_type;

SELECT 
    customer_id,
    SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
HAVING total_balance > 50000
ORDER BY total_balance DESC;

SELECT 
   transaction_id, 
   amount,
   CASE
    WHEN amount >= 5000 THEN 'High Amount'
    WHEN amount >= 1000 THEN 'Medium Amount'
    ELSE 'Low Amount'
   END AS amount_category
FROM transactions;

SELECT 
   transaction_type,
   COUNT(*) AS total_transaction,
   SUM(
    CASE
     WHEN status = 'completed' THEN 1
     ELSE 0
    END 
   ) AS completed_transaction,
   SUM(
    CASE
     WHEN status = 'completed' THEN amount
     ELSE 0
    END 
   ) AS completed_amount
FROM transactions
GROUP BY transaction_type;


