USE fintrack;

SELECT
   transaction_type,
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

SELECT
   transaction_type,
   SUM(
    CASE
     WHEN status = 'completed' THEN 1
     ELSE 0
    END
   ) AS completed_transaction,
   SUM(
    CASE
     WHEN status = 'failed' THEN 1
     ELSE 0
    END
   ) AS failed_transaction,
   SUM(
    CASE
     WHEN status = 'pending' THEN 1
     ELSE 0
    END
   ) AS pending_transaction
FROM transactions
GROUP BY transaction_type;

SELECT 
   COUNT(*) AS total_transaction,
   DATE(transaction_date) AS transaction_day,
   SUM(amount) AS total_amount,
   AVG(amount) AS average_amount
FROM transactions
WHERE status = 'completed'
GROUP BY transaction_day;

SELECT 
    COUNT(*) AS total_transaction,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END)
       AS completed_status,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END)
            / NULLIF(COUNT(*), 0),
            2
    ) AS success_rate_percent
FROM transactions;

SELECT 
    channel,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,
    COUNT(*) AS total_transaction
FROM transactions
WHERE status = 'completed'
GROUP BY channel
ORDER BY total_amount DESC;

SELECT 
    transaction_type,
    status,
    SUM(amount) AS total_amount,
    COUNT(*) AS total_transaction
FROM transactions
GROUP BY transaction_type, status
ORDER BY transaction_type, total_transaction DESC;



