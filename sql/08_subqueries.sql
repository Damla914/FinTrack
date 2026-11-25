USE fintrack;

SELECT 'customers' as table_name, COUNT(*) AS total
FROM customers

UNION ALL 

SELECT 'accounts', COUNT(*)
FROM accounts

UNION ALL

SELECT 'transactions', COUNT(*)
FROM transactions

UNION ALL

SELECT 'loans', COUNT(*)
FROM loans

UNION ALL

SELECT 'payments', COUNT(*)
FROM payments;


SELECT COUNT(*) AS invalid_accounts
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS Null;


SELECT COUNT(*) as invalid_transactions
FROM transactions t
LEFT JOIN accounts a
    ON t.account_id = a.account_id
WHERE a.account_id IS NULL;


SELECT COUNT(*) as invalid_payments
FROM payments p
LEFT JOIN loans l
    ON p.loan_id = l.loan_id
WHERE l.loan_id IS NULL;


SELECT 
   account_id,
   customer_id,
   account_type,
   balance
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
)
ORDER BY balance DESC;


SELECT 
    l.loan_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    l.loan_type,
    l.loan_amount
FROM loans l
INNER JOIN customers c 
    on l.customer_id = c.customer_id
WHERE loan_amount > (
    SELECT AVG(loan_amount)
    FROM loans
)
ORDER BY loan_amount DESC;


SELECT 
    account_id,
    customer_id,
    account_type,
    balance
FROM accounts
WHERE customer_id IN (
    SELECT customer_id
    FROM loans
)
ORDER BY customer_id;


SELECT 
    a.account_id,
    a.account_type,
    a.balance
FROM accounts a
WHERE NOT EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.account_id = a.account_id
);

SELECT
    l.loan_id,
    l.loan_type,
    l.loan_amount
FROM loans l
WHERE EXISTS (
    SELECT 1
    FROM payments p 
    WHERE p.loan_id = l.loan_id
    AND p.payment_status = 'completed'
);

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c 
WHERE NOT EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
);

-- Kredisi olamayn müşteriler
SELECT
   c.customer_id,
   c.first_name,
   c.last_name
FROM customers c
WHERE c.customer_id NOT IN(
    SELECT l.customer_id
    FROM loans l
);

-- Müşteri bazında toplam hesap bakiyesi ortalamadan yüksek olanlar
SELECT
    customer_id,
    SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
HAVING SUM(balance) > (
    SELECT AVG(customer_balances.total_balance)
    FROM(
        SELECT 
            customer_id,
            SUM(balance) as total_balance
        FROM accounts
        GROUP BY customer_id
    ) AS customer_balances
)
ORDER BY total_balance DESC;

