USE fintrack;

INSERT INTO customers(
    first_name,
    last_name,
    birth_date,
    city,
    monthly_income,
    registration_date,
    status
)
VALUES(
    'Ayşe',
    'Yılmaz',
    '1995-04-12',
    'İstanbul',
    45000.00,
    '2025-01-15',
    'active'
);

INSERT INTO customers(
    first_name,
    last_name,
    birth_date,
    city,
    monthly_income,
    registration_date,
    status
)
VALUES(
    'Mehmet',
    'Demir',
    '1990-08-22',
    'Ankara',
    62000.00,
    '2025-03-10',
    'active'
);

INSERT INTO customers (
    first_name,
    last_name,
    birth_date,
    city,
    monthly_income,
    registration_date,
    status
)
VALUES
    ('Zeynep', 'Kaya', '1998-02-15', 'İzmir', 52000.00, '2025-04-05', 'active'),
    ('Emre', 'Yıldız', '1993-11-20', 'Bursa', 38000.00, '2025-05-12', 'active'),
    ('Elif', 'Çelik', '2000-07-08', 'İstanbul', 47000.00, '2025-06-18', 'active');

SELECT* FROM customers;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT customer_id, first_name, last_name
FROM customers
ORDER BY customer_id;

INSERT INTO accounts (
    customer_id,
    account_type,
    balance,
    currency,
    open_date,
    status
)
VALUES
    (1, 'checking',  25000.00, 'TRY', '2025-01-20', 'active'),
    (1, 'savings',   80000.00, 'TRY', '2025-02-10', 'active'),
    (2, 'checking',  18500.00, 'TRY', '2025-03-15', 'active'),
    (3, 'savings',  120000.00, 'TRY', '2025-04-08', 'active'),
    (4, 'checking',  32000.00, 'TRY', '2025-05-17', 'active'),
    (5, 'checking',  14500.00, 'TRY', '2025-06-22', 'active');

SELECT* FROM accounts;

SELECT COUNT(*) AS total_accounts
FROM accounts;

SELECT account_id, customer_id, account_type
FROM accounts
ORDER BY customer_id;

INSERT INTO transactions (
    account_id,
    transaction_date,
    transaction_type,
    amount,
    merchant_category,
    channel,
    status
)
VALUES
    (1, '2025-07-01 10:15:00', 'deposit',    10000.00, NULL,          'branch', 'completed'),
    (1, '2025-07-02 14:30:00', 'payment',      450.00, 'groceries',   'mobile', 'completed'),
    (2, '2025-07-03 09:20:00', 'deposit',     15000.00, NULL,          'branch', 'completed'),
    (3, '2025-07-04 18:45:00', 'payment',      850.00, 'restaurants', 'mobile', 'completed'),
    (4, '2025-07-05 12:10:00', 'withdrawal',  2000.00, NULL,          'atm',    'completed'),
    (5, '2025-07-06 16:25:00', 'payment',     1200.00, 'shopping',    'online', 'completed'),
    (6, '2025-07-07 11:00:00', 'transfer',    3000.00, NULL,          'mobile', 'pending'),
    (1, '2025-07-08 20:15:00', 'payment',      320.00, 'transport',   'mobile', 'completed'),
    (3, '2025-07-09 13:40:00', 'payment',      650.00, 'groceries',   'online', 'failed'),
    (4, '2025-07-10 15:50:00', 'deposit',     5000.00, NULL,          'branch', 'completed');

SELECT* FROM transactions;

SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT transaction_id, account_id, transaction_type, status
FROM transactions
ORDER BY transaction_id;

INSERT INTO loans (
    customer_id,
    loan_type,
    loan_amount,
    interest_rate,
    start_date,
    due_date,
    status
)
VALUES
    (1, 'personal',  100000.00, 24.50, '2025-01-15', '2027-01-15', 'active'),
    (2, 'vehicle',   350000.00, 19.75, '2025-02-01', '2028-02-01', 'active'),
    (3, 'personal',   50000.00, 22.00, '2025-03-10', '2026-03-10', 'paid'),
    (4, 'housing',   800000.00, 17.25, '2025-04-01', '2030-04-01', 'active'),
    (5, 'personal',   75000.00, 26.00, '2025-05-20', '2027-05-20', 'active');

SELECT* FROM loans;

SELECT COUNT(*) AS total_loans
FROM loans;

SELECT loan_id, customer_id, loan_type, status
FROM loans
ORDER BY loan_id;

INSERT INTO payments (
    loan_id,
    payment_date,
    amount,
    payment_status
)
VALUES
    (1, '2025-02-15', 5000.00, 'paid'),
    (1, '2025-03-15', 5000.00, 'paid'),
    (1, '2025-04-15', 5000.00, 'paid'),
    (2, '2025-03-01', 12000.00, 'paid'),
    (2, '2025-04-01', 12000.00, 'paid'),
    (3, '2025-04-10', 5000.00, 'paid'),
    (3, '2025-05-10', 5000.00, 'paid'),
    (4, '2025-05-01', 18000.00, 'paid'),
    (4, '2025-06-01', 18000.00, 'pending'),
    (5, '2025-06-20', 4000.00, 'paid');

SELECT* FROM payments;

SELECT COUNT(*) AS total_payments
FROM payments;

SELECT payment_id, loan_id, amount
FROM payments
ORDER BY payment_id;
