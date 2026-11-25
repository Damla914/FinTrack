USE fintrack;

WITH customer_balances AS(
    SELECT 
       customer_id,
       SUM(balance) as total_balance
    FROM accounts
    GROUP BY customer_id
)

SELECT *
FROM customer_balances;

-- Müşteri bazında toplam hesap bakiyesi ortalamadan yüksek olanlar

WITH customer_balances AS(
    SELECT 
       customer_id,
       SUM(balance) as total_balance
    FROM accounts
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_balance
FROM customer_balances
WHERE total_balance > (
    SELECT AVG(total_balance)
    FROM customer_balances
)
ORDER BY total_balance DESC;


-- Müşterilerin toplam kredi tutarları ve toplam hesap tutarlarını  birlikte analiz etme

WITH customer_balances AS(
    SELECT 
       customer_id,
       SUM(balance) as total_balance
    FROM accounts
    GROUP BY customer_id
),

customer_loans AS(
    SELECT
        customer_id,
        SUM(loan_amount) as total_loan
    FROM loans
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.total_balance,
    l.total_loan
FROM customer_balances c 
LEFT JOIN customer_loans l 
    ON c.customer_id = l.customer_id
ORDER BY c.total_balance DESC;


-- Her müşterinin toplam bakiyesini büyükten küçüğe sırala

WITH customer_balances AS(
    SELECT 
       customer_id,
       SUM(balance) as total_balance
    FROM accounts
    GROUP BY customer_id
)

SELECT *
FROM customer_balances
ORDER BY total_balance DESC;


SELECT currency
FROM accounts

UNION

SELECT currency
FROM accounts;

SELECT currency
FROM accounts

UNION ALL

SELECT currency
FROM accounts;

WITH customer_balances AS (
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
),

customer_loans AS (
    SELECT
        customer_id,
        SUM(loan_amount) AS total_loan
    FROM loans
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.total_balance,
    COALESCE(l.total_loan, 0) AS total_loan
FROM customer_balances c
LEFT JOIN customer_loans l
    ON c.customer_id = l.customer_id;


WITH customer_balances AS (
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
),

customer_loans AS (
    SELECT
        customer_id,
        SUM(loan_amount) AS total_loan
    FROM loans
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.total_balance,
    IFNULL(l.total_loan, 0) AS total_loan
FROM customer_balances c
LEFT JOIN customer_loans l
    ON c.customer_id = l.customer_id;


   