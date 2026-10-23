USE fintrack;

SELECT first_name, last_name, city
FROM customers
WHERE city = 'İstanbul';

SELECT first_name, last_name, monthly_income
FROM customers
WHERE monthly_income >= 45000;

SELECT first_name, last_name, monthly_income
FROM customers
ORDER BY monthly_income DESC;

SELECT COUNT(*) as total_customers
FROM customers;

SELECT SUM(balance) as total_balance
FROM accounts;

SELECT AVG(balance) as avg_balance
FROM accounts;

SELECT * 
FROM customers
WHERE customer_id = 6;

SELECT COUNT(*) as account_count
FROM accounts
WHERE customer_id = 6;

SELECT COUNT(*) as loan_count
FROM loans
WHERE customer_id = 6;

DELETE FROM customers
WHERE customer_id = 6;

SELECT * 
FROM customers
WHERE customer_id = 6;

SELECT first_name, last_name, city 
from customers
WHERE customer_id = 2;

UPDATE customers
SET city = 'Eskişehir'
WHERE customer_id = 2;

SELECT first_name, last_name, city 
from customers
WHERE customer_id = 2;

SELECT  transaction_id, transaction_type, amount, status
FROM transactions
WHERE status = 'failed';

SELECT transaction_id, transaction_date, amount, status
FROM transactions
WHERE transaction_date >= '2025-07-05 12:10:00';

