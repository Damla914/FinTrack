WITH customer_balances AS(
    SELECT 
       customer_id,
       SUM(balance) as total_balance,
       COUNT(*) as account_count
    FROM accounts
    GROUP BY customer_id
),

customer_loans AS(
    SELECT
        customer_id,
        SUM(loan_amount) as total_loan,
        COUNT(*) as loan_count
    FROM loans
    GROUP BY customer_id
)

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(a.total_balance,0),
    COALESCE(a.account_count,0),
    COALESCE(l.total_loan,0),
    COALESCE(l.loan_count,0)
FROM customers c 
LEFT JOIN customer_balances a
   ON c.customer_id = a.customer_id
LEFT JOIN customer_loans l 
   ON a.customer_id = l.customer_id;


SELECT 
   a.customer_id,
   SUM(t.amount) AS total_amount
FROM accounts a 
INNER JOIN transactions t
   ON a.account_id = t.account_id
WHERE t.status = 'successful'
GROUP BY a.customer_id
ORDER BY total_amount DESC
LIMIT 10;


SELECT
    l.loan_id,
    l.loan_type,
    SUM(
      CASE
        WHEN p.payment_status = 'completed' THEN 1
        ELSE 0
      END
    ) AS completed_count,
    SUM(
      CASE
        WHEN p.payment_status = 'failed' THEN 1
        ELSE 0
      END
    ) AS failed_count
FROM loans l
LEFT JOIN payments p
    ON l.loan_id = p.loan_id
GROUP BY
    l.loan_id,
    l.loan_type
ORDER BY l.loan_id;


WITH customer_balances AS (
    SELECT 
       customer_id,
       SUM(balance) as total_balance
    FROM accounts
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_balance,
    CASE
        WHEN total_balance < 10000 THEN 'Low Balance'
        WHEN total_balance <= 50000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS customer_segment
FROM customer_balances;

