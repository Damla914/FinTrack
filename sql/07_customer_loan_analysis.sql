USE fintrack;

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(a.balance) AS total_balance,
    COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_balance DESC;


SELECT 
    customer_id,
    first_name,
    last_name,
    monthly_income,
    CASE
     WHEN monthly_income >= 60000 THEN 'High Income'
     WHEN monthly_income >= 40000 THEN 'Medium Income'
     ELSE 'Low Income'
    END AS income_category
FROM customers
ORDER BY monthly_income DESC;


SELECT
    loan_type,
    COUNT(*) AS loan_count,
    SUM(loan_amount) AS total_loan_amount,
    AVG(loan_amount) AS average_loan_amount
FROM loans
GROUP BY loan_type
ORDER BY total_loan_amount DESC;


SELECT 
    status,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount
FROM loans
GROUP BY status
ORDER BY total_loan_amount DESC;


SELECT
    payment_status,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_payment_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payment_amount DESC;


SELECT
    c.first_name,
    c.last_name,
    COALESCE(SUM(l.loan_amount),0) AS total_loan_amount
FROM customers c
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_loan_amount DESC;


SELECT
    l.loan_id,
    l.customer_id,
    l.loan_amount,
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'paid' THEN p.amount
            ELSE 0
        END
    ), 0) AS total_paid,
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'pending' THEN p.amount
            ELSE 0
        END
    ), 0) AS total_pending
FROM loans l
LEFT JOIN payments p
    ON l.loan_id = p.loan_id
GROUP BY
    l.loan_id,
    l.customer_id,
    l.loan_amount
ORDER BY l.loan_id;



