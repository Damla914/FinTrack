# FinTrack – Financial Analytics Platform

## About the Project

FinTrack is a financial analytics project designed to explore and analyze customer information, bank accounts, financial transactions, loans, and loan payments within a financial institution.

The project combines relational database design, advanced SQL querying, Python-based data analysis, and interactive data visualization to simulate a financial analytics workflow.

## Project Objectives

- Design and implement a relational database using MySQL.
- Generate and manage synthetic financial data.
- Analyze customer profiles, account balances, and transaction activities.
- Explore loan portfolios and payment performance.
- Perform data quality checks and financial analysis using SQL.
- Apply Python for exploratory data analysis.
- Build interactive dashboards in Power BI to communicate financial insights.

## Database Design

The database consists of five relational tables:

| Table | Description |
|---|---|
| **Customers** | Customer information, demographics, and registration details. |
| **Accounts** | Customer accounts, account types, balances, and statuses. |
| **Transactions** | Financial transactions, amounts, dates, channels, and statuses. |
| **Loans** | Loan information, loan types, amounts, interest rates, and maturity dates. |
| **Payments** | Loan payment amounts, dates, and payment statuses. |

Primary keys and foreign keys are used to establish relationships and maintain referential integrity.

### Database Relationships

- Customers → Accounts (One-to-Many)
- Accounts → Transactions (One-to-Many)
- Customers → Loans (One-to-Many)
- Loans → Payments (One-to-Many)

## Technologies

- **Database:** MySQL
- **Query Language:** SQL
- **Data Generation:** Python, Faker
- **Data Analysis:** Python, Pandas, NumPy, Matplotlib
- **Visualization:** Power BI

## Synthetic Dataset

The project uses Python and the Faker library to generate synthetic financial data.

The database currently contains **28,000 records** across five tables:

| Table | Number of Records |
|---|---:|
| Customers | 1,000 |
| Accounts | 1,500 |
| Transactions | 20,000 |
| Loans | 500 |
| Payments | 5,000 |
| **Total** | **28,000** |

The generated data is used for development and analysis. No real customer or financial information is included.

## SQL Development

The database schema, synthetic data generation, and foundational SQL analysis have been completed.

SQL development currently covers:

### 1. Database Fundamentals
- Database and table creation.
- Primary keys and foreign key constraints.
- Data insertion and modification using INSERT, UPDATE, and DELETE.
- Data retrieval using SELECT, WHERE, and ORDER BY.

### 2. Joins and Aggregations
- INNER JOIN and LEFT JOIN.
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX.
- GROUP BY and HAVING.
- Multi-table financial analysis.

### 3. Advanced SQL
- Subqueries and nested queries.
- Correlated subqueries.
- EXISTS and NOT EXISTS.
- Common Table Expressions (CTEs).
- UNION and UNION ALL.
- NULL handling using COALESCE and IFNULL.
- Conditional analysis using CASE WHEN.

### 4. Financial Analysis
- Customer account balance analysis.
- Customer financial profile analysis.
- Top customers by successful transaction volume.
- Loan portfolio analysis.
- Loan payment performance.
- Customer segmentation based on total account balances.

SQL scripts are organized in the `sql/` directory.

## Project Structure

```text
FinTrack/
│
├── data_generation/
│   ├── data_list.py
│   ├── data_generator.py
│   └── generate_data.py
│
├── sql/
│   ├── Database creation and setup scripts
│   ├── Basic SQL analysis scripts
│   ├── Subquery analysis
│   ├── CTE analysis
│   ├── UNION and NULL handling
│   └── Advanced SQL analysis
│
├── .env
├── .gitignore
├── requirements.txt
└── README.md
```

## Project Status

🚧 **In Progress**

### Completed
- Relational database design and implementation.
- Creation of all five database tables.
- Synthetic data generation using Python and Faker.
- Insertion of 28,000 records into MySQL.
- Foundational SQL queries and data manipulation.
- JOIN operations and aggregate analysis.
- Subqueries and correlated subqueries.
- CTEs, UNION operations, and NULL handling.
- Advanced financial analysis using SQL.

### Upcoming
- Window functions and advanced analytical queries.
- Data quality validation and database optimization.
- Exploratory Data Analysis (EDA) using Python.
- Interactive financial dashboards using Power BI.

## Future Improvements

- Expand financial analysis with advanced SQL techniques.
- Perform customer segmentation and transaction trend analysis.
- Analyze loan repayment behavior and portfolio performance.
- Develop reusable Python data analysis workflows.
- Create interactive dashboards with key financial KPIs.
- Integrate the database with an API layer.
