import random
from faker import Faker
from datetime import datetime, timedelta, date, time
from data_list import TURKISH_CITIES, FIRST_NAMES, LAST_NAMES 

fake = Faker('tr_TR')

loan_duration = random.choice([365, 730, 1095, 1825]) 

def generate_customer_data():
    customers = {
        "first_name": random.choice(FIRST_NAMES),
        "last_name": random.choice(LAST_NAMES),
        "birth_date": fake.date_of_birth(minimum_age=18, maximum_age=75),
        "city": random.choice(TURKISH_CITIES),
        "monthly_income": round(random.uniform(15000, 150000), 2),
        "registration_date": fake.date_between(start_date='-5y', end_date='today'),
        "status": random.choice(["active", "inactive"])
    }

    return customers

def generate_account_data(customer_id, registration_date):
    accounts = {
        "customer_id": customer_id,
        "account_type": random.choice(["checking", "savings", "investment"]),
        "balance": round(random.uniform(0, 100000), 2),
        "currency": "TRY",
        "open_date": fake.date_between(start_date=registration_date, end_date='today'),
        "status": random.choice(["active", "inactive"])
    }

    return accounts

def generate_transaction_data(account_id, account_open_date):

    transaction_start = datetime.combine(account_open_date, time.min)

    transactions = {
        "account_id": account_id,
        "transaction_type": random.choice(["income", "expense", "transfer"]),
        "amount": round(random.uniform(10, 10000), 2),
        "transaction_date": fake.date_time_between(
            start_date=transaction_start,
            end_date='now'
        ),
        "channel": random.choice(["atm", "branch", "pos", "mobile","web"]),
        "status": random.choice(["successful", "pending", "failed"]),
        "merchant_category": random.choice([ 
            "food", "shopping", "transportation",
            "health", "entertainment", "education",
            "utilities", None
    ])
    }
    return transactions

def generate_loan_data(customer_id):

    start_date = fake.date_between(start_date='-5y', end_date='today')
    due_date = start_date + timedelta(days=loan_duration)

    loans = {
        "customer_id": customer_id,
        "loan_type": random.choice(["personal", "housing", "vehicle", "education"]),
        "loan_amount": round(random.uniform(5000, 500000), 2),
        "interest_rate": round(random.uniform(5, 20), 2),
        "start_date": start_date,
        "due_date": due_date,
        "status": random.choice(["active", "closed", "defaulted"])
    }
    return loans

def generate_payment_data(loan_id, loan_start_date, loan_due_date, loan_amount):

    payment_end_date = min(loan_due_date, date.today())

    payments = {
        "loan_id": loan_id,
        "amount": round(random.uniform(100, min(10000, float(loan_amount))), 2),
        "payment_date": fake.date_between(start_date=loan_start_date, end_date=payment_end_date),
        "payment_status": random.choice(["completed", "pending", "failed"])
    }
    return payments