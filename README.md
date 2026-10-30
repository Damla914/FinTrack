# FinTrack – Financial Analytics Platform

## About the Project

FinTrack is a financial analytics project focused on analyzing customers, accounts, transactions, loans, and loan payments within a financial institution.

The project aims to build a relational database using MySQL and perform financial data analysis using SQL, Python, and Power BI.

## Project Objectives

- Design and implement a relational database.
- Analyze customer and account data.
- Explore transaction patterns and financial activity.
- Analyze loan portfolios and payment records.
- Practice SQL querying, data quality validation, and data analysis.
- Develop interactive dashboards to present key financial insights.

## Database Design

The database consists of five main tables:

- **Customers:** Customer information and registration details.
- **Accounts:** Account types, balances, currencies, and account statuses.
- **Transactions:** Transaction dates, types, amounts, channels, and statuses.
- **Loans:** Loan types, amounts, interest rates, and maturity dates.
- **Payments:** Loan payment amounts, dates, and payment statuses.

The database uses primary keys and foreign keys to maintain relationships between tables and support data integrity.

## Technologies

- **Database:** MySQL
- **Query Language:** SQL
- **Data Analysis:** Python, Pandas, NumPy, Matplotlib
- **Visualization:** Power BI
- **API Testing:** Postman (planned)

## SQL Development

The initial database implementation and foundational SQL analysis have been completed.

The SQL work currently covers:

- Database and table creation.
- Sample data insertion.
- Basic queries using SELECT, WHERE, and ORDER BY.
- Data modification using INSERT, UPDATE, and DELETE.
- Table relationships and JOIN operations (INNER JOIN and LEFT JOIN).
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX).
- Data grouping and filtering using GROUP BY and HAVING.
- Conditional analysis using CASE WHEN.
- Financial transaction analysis.
- Customer, account, loan, and payment analysis.

SQL scripts are organized in the `sql/` directory.

## Project Status

🚧 In progress

The database schema, sample data, and foundational SQL analysis have been completed.

The project is currently progressing toward advanced SQL analysis. Upcoming stages include subqueries, CTEs, window functions, data quality checks, Python-based exploratory data analysis, and interactive Power BI dashboards.

## Data

The project uses synthetic sample data for development and analysis. No real customer or financial information is included.

## Future Improvements

- Advanced SQL queries using subqueries, CTEs, and window functions.
- Data quality checks and database optimization.
- Python-based exploratory data analysis.
- Interactive Power BI dashboards.
- Optional REST API integration and API testing.
