USE fintrack;

SELECT customers.first_name, customers.last_name, accounts.account_id, accounts.balance
FROM customers
INNER JOIN accounts
   ON customers.customer_id =  accounts.customer_id;

SELECT customers.first_name, customers.last_name, accounts.account_type
FROM customers
INNER JOIN accounts
   ON customers.customer_id =  accounts.customer_id;

SELECT customers.customer_id, customers.first_name, customers.last_name, accounts.account_id, accounts.balance
FROM customers
LEFT JOIN accounts
   ON customers.customer_id = accounts.customer_id;

SELECT customers.first_name, customers.last_name, customers.city, accounts.balance
FROM customers
LEFT JOIN accounts
   ON customers.customer_id = accounts.customer_id
   WHERE city = 'İstanbul';





