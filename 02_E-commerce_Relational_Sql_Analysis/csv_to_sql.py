import pandas as pd
import sqlite3

# Connect to SQLite database (creates it if it doesn't exist)
conn = sqlite3.connect('ecommerce.db')

# Mapping of CSV files to their corresponding SQL table names
# (CSV files are located in the same directory as this script)
tables = {
    'olist_customers_dataset.csv': 'customers',
    'olist_geolocation_dataset.csv': 'geolocation',
    'olist_order_items_dataset.csv': 'order_items',
    'olist_order_payments_dataset.csv': 'order_payments',
    'olist_order_reviews_dataset.csv': 'order_reviews',
    'olist_orders_dataset.csv': 'orders',
    'olist_products_dataset.csv': 'products',
    'olist_sellers_dataset.csv': 'sellers',
    'product_category_name_translation.csv': 'product_category_name_translation'
}

for csv_file, table_name in tables.items():
    print(f"📥 Loading {csv_file} into '{table_name}' table...")
    
    # Read CSV file into a pandas DataFrame
    df = pd.read_csv(csv_file)
    
    # Clean column names by removing extra spaces
    df.columns = [col.strip() for col in df.columns]
    
    # Append data to the existing table (do not overwrite)
    try:
        df.to_sql(table_name, conn, if_exists='append', index=False)
    except Exception as e:
        print(f"⚠️ Error loading {csv_file} into {table_name}: {e}")

# Commit all changes and close the connection
conn.commit()
conn.close()

print("✅ All CSV files have been successfully loaded into the existing tables!")
