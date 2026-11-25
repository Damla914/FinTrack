import os
import mysql.connector
from dotenv import load_dotenv
import random
from data_generator import (
    generate_customer_data,
    generate_account_data,
    generate_transaction_data,
    generate_loan_data,
    generate_payment_data
)

load_dotenv()

TARGET_COUNTS = {
    "customers": 1000,
    "accounts": 1500,
    "transactions": 20000,
    "loans": 500,
    "payments": 5000
}

def create_connection():

    connection = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT")),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )
    return connection

def get_table_counts(connection):

    cursor = connection.cursor()

    current_counts = {}

    for table in TARGET_COUNTS:
        query = f"SELECT COUNT(*) FROM {table}"
        cursor.execute(query)
        result = cursor.fetchone()
        current_counts[table] = result[0]

    cursor.close()

    return current_counts

def show_remaining_records(current_counts):

    print("\n-------Fintracker Database Records-------\n")

    total_current = 0
    total_target = 0
    total_remaining = 0

    for table, target in TARGET_COUNTS.items():
        current = current_counts.get(table)
        remaining = max(target - current, 0)
        total_current += current
        total_target += target
        total_remaining += remaining

        print(f"Tablo:{table.capitalize()}")
        print(f"Mevcut Kayıt Sayısı: {current}")
        print(f"Hedef Kayıt Sayısı: {target}")
        print(f"Eklenecek Kayıt Sayısı: {remaining}")
        print("-" * 35)

    print("\n-------Toplam Kayıt Durumu-------\n")
    print(f"Toplam Mevcut Kayıt Sayısı: {total_current}")
    print(f"Toplam Hedef Kayıt Sayısı: {total_target}")
    print(f"Toplam Eklenecek Kayıt Sayısı: {total_remaining}\n")

def insert_customers(connection, customer_count):
    
    if customer_count <=0:
        print("Eklenecek yeni müşteri bulunmuyor.")
        return 

    cursor = connection.cursor()

    try:
        customers = []

        for _ in range(customer_count):
            customer_data = generate_customer_data()
            customers.append((
                customer_data["first_name"],
                customer_data["last_name"],
                customer_data["birth_date"],
                customer_data["city"],
                customer_data["monthly_income"],
                customer_data["registration_date"],
                customer_data["status"]
            ))

        query = """
            INSERT INTO customers (
                first_name,
                last_name,
                birth_date,
                city,
                monthly_income,
                registration_date,
                status
            ) 
            VALUES (%s , %s, %s, %s, %s, %s, %s)
        """

        cursor.executemany(query, customers)
        connection.commit()

        print(f"{cursor.rowcount} yeni müşteri başarıyla eklendi.")

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")
        connection.rollback()

    finally:
        cursor.close()

def insert_accounts(connection, account_count):

    if account_count <= 0:
        print("Eklenecek yeni hesap bulunmuyor.")
        return

    cursor = connection.cursor()

    try:
        cursor.execute(
            """
                SELECT customer_id, registration_date
                FROM customers
            """
        )

        customer_records = cursor.fetchall()

        if not customer_records:
            print("Müşteri tablosunda kayıt bulunamadı. Lütfen önce müşteri verilerini ekleyin.")
            return

        accounts = []

        for _ in range(account_count):

            customer_id, registration_date = random.choice(customer_records)
        
            account_data = generate_account_data(customer_id, registration_date)
            accounts.append((
                account_data["customer_id"],
                account_data["account_type"],
                account_data["balance"],
                account_data["currency"],
                account_data["open_date"],
                account_data["status"]
            ))

        query = """
            INSERT INTO accounts (
                customer_id,
                account_type,
                balance,
                currency,
                open_date,
                status
            ) 
            VALUES (%s , %s, %s, %s, %s, %s)
        """

        cursor.executemany(query, accounts)
        connection.commit()

        print(f"{cursor.rowcount} yeni hesap başarıyla eklendi.")

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")
        connection.rollback()

    finally:
        cursor.close()


def insert_transactions(connection, transaction_count):

    if transaction_count <= 0:
        print("Eklenecek yeni işlem bulunmuyor.")
        return

    cursor = connection.cursor()

    try:
        cursor.execute(
            """
                SELECT account_id, open_date
                FROM accounts
            """
        )

        account_records = cursor.fetchall()

        if not account_records:
            print("Hesap tablosunda kayıt bulunamadı. Lütfen önce hesap verilerini ekleyin.")
            return

        transactions = []

        for _ in range(transaction_count):

            account_id, open_date = random.choice(account_records)
        
            transaction_data = generate_transaction_data(account_id, account_open_date=open_date)
            transactions.append((
                transaction_data["account_id"],
                transaction_data["transaction_type"],
                transaction_data["amount"],
                transaction_data["transaction_date"],
                transaction_data["status"],
                transaction_data["channel"],
                transaction_data["merchant_category"]
            ))

        query = """
            INSERT INTO transactions (
                account_id,
                transaction_type,
                amount,
                transaction_date,
                status,
                channel,
                merchant_category
            ) 
            VALUES (%s , %s, %s, %s, %s, %s, %s)
        """

        cursor.executemany(query, transactions)
        connection.commit()

        print(f"{cursor.rowcount} yeni işlem başarıyla eklendi.")

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")
        connection.rollback()

    finally:
        cursor.close()

def insert_loans(connection, loan_count):

    if loan_count <= 0:
        print("Eklenecek yeni kredi bulunmuyor.")
        return

    cursor = connection.cursor()

    try:
        cursor.execute(
            """
                SELECT customer_id
                FROM customers
            """
        )

        customer_records = cursor.fetchall()

        if not customer_records:
            print("Müşteri tablosunda kayıt bulunamadı. Lütfen önce müşteri verilerini ekleyin.")
            return

        loans = []

        for _ in range(loan_count):

            customer_id = random.choice(customer_records)[0]
        
            loan_data = generate_loan_data(customer_id)
            loans.append((
                loan_data["customer_id"],
                loan_data["loan_type"],
                loan_data["loan_amount"],
                loan_data["interest_rate"],
                loan_data["start_date"],
                loan_data["due_date"],
                loan_data["status"]
            ))

        query = """
            INSERT INTO loans (
                customer_id,
                loan_type,
                loan_amount,
                interest_rate,
                start_date,
                due_date,
                status
            ) 
            VALUES (%s , %s, %s, %s, %s, %s, %s)
        """

        cursor.executemany(query, loans)
        connection.commit()

        print(f"{cursor.rowcount} yeni kredi başarıyla eklendi.")

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")
        connection.rollback()

    finally:
        cursor.close()

def insert_payments(connection, payment_count):

    if payment_count <= 0:
        print("Eklenecek yeni ödeme bulunmuyor.")
        return

    cursor = connection.cursor()

    try:
        cursor.execute(
            """
                SELECT loan_id, start_date, due_date, loan_amount
                FROM loans
            """
        )

        loan_records = cursor.fetchall()

        if not loan_records:
            print("Kredi tablosunda kayıt bulunamadı. Lütfen önce kredi verilerini ekleyin.")
            return

        payments = []

        for _ in range(payment_count):

            loan_id, start_date, due_date, loan_amount = random.choice(loan_records)
        
            payment_data = generate_payment_data(loan_id, loan_start_date = start_date, loan_due_date = due_date, loan_amount = loan_amount)
            payments.append((
                payment_data["loan_id"],
                payment_data["amount"],
                payment_data["payment_date"],
                payment_data["payment_status"]
            ))

        query = """
            INSERT INTO payments (
                loan_id,
                amount,
                payment_date,
                payment_status
            ) 
            VALUES (%s , %s, %s, %s)
        """

        cursor.executemany(query, payments)
        connection.commit()

        print(f"{cursor.rowcount} yeni ödeme başarıyla eklendi.")

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")
        connection.rollback()

    finally:
        cursor.close()     


def main():
    
    connection = None

    try:
        connection = create_connection()
        print("Veritabanına başarıyla bağlanıldı.")

        current_counts = get_table_counts(connection)

        show_remaining_records(current_counts)

        customer_counts = max(TARGET_COUNTS["customers"] - current_counts["customers"], 0)
        account_counts = max(TARGET_COUNTS["accounts"] - current_counts["accounts"], 0)
        transaction_counts = max(TARGET_COUNTS["transactions"] - current_counts["transactions"], 0)
        loan_counts = max(TARGET_COUNTS["loans"] - current_counts["loans"], 0)
        payment_counts = max(TARGET_COUNTS["payments"] - current_counts["payments"], 0)
        
        print("Müşteri verileri ekleniyor...")
        insert_customers(connection, customer_counts)

        print("Hesap verileri ekleniyor...")
        insert_accounts(connection, account_counts)

        print("İşlem verileri ekleniyor...")
        insert_transactions(connection, transaction_counts)

        print("Kredi verileri ekleniyor...")
        insert_loans(connection, loan_counts)

        print("Ödeme verileri ekleniyor...")
        insert_payments(connection, payment_counts)

        updated_counts = get_table_counts(connection)

        print("\nGüncellenmiş Kayıt Durumu:")
        show_remaining_records(updated_counts)

    except mysql.connector.Error as error:
        print(f"Veritabanı hatası: {error}")

    finally: 
        if connection and connection.is_connected():
            connection.close()
            print("\nVeritabanı bağlantısı kapatıldı.")


if __name__ == "__main__":
    main()