-- Brazilian E-Commerce SQL Analysis
This project analyzes the Brazilian E-Commerce Public Dataset from Olist using Python and SQL.
It demonstrates a full data pipeline: loading, cleaning, relational database design, and SQL queries for insights.

---

📊 Dataset Overview
```text
The dataset contains multiple CSV files representing different entities in an e-commerce business:

olist_customers_dataset.csv → Customer details

olist_geolocation_dataset.csv → Location coordinates

olist_order_items_dataset.csv → Order item details

olist_order_payments_dataset.csv → Payment information

olist_order_reviews_dataset.csv → Customer reviews

olist_orders_dataset.csv → Order metadata

olist_products_dataset.csv → Product details

olist_sellers_dataset.csv → Seller details

product_category_name_translation.csv → Product category translations
```
---

Source: Kaggle - Brazilian E-Commerce Public Dataset by Olist

---

 --Tech Stack
Python → Pandas for data cleaning & preprocessing

SQLite / PostgreSQL → Relational database storage

SQL → Data exploration, joins, window functions

Matplotlib / Seaborn (optional) → Data visualization

---

📂 Project Structure
plaintext
Kopyala
Düzenle
brazilian-ecommerce-sql-analysis/
├── data/
│   ├── olist_customers_dataset.csv
│   ├── olist_geolocation_dataset.csv
│   ├── ...
├── load_data.py               # Load & clean CSV files into database
├── database_schema.sql        # CREATE TABLE scripts with relationships
├── sql/
│   ├── 01_basic_queries.sql
│   ├── 02_joins_analysis.sql
│   ├── 03_window_functions.sql
│   ├── 04_customer_behavior.sql
│   └── 05_product_performance.sql
└── README.md

---

-- How to Run
1. Clone the repository
git clone https://github.com/<your-username>/brazilian-ecommerce-sql-analysis.git
cd brazilian-ecommerce-sql-analysis

2. Install dependencies
pip install -r requirements.txt

3. Load data into database
python load_data.py

4. Run SQL queries
Open the database file (ecommerce.db) in your SQL IDE (e.g., DBeaver, SQLiteStudio)
Execute SQL scripts from the sql/ folder

---

-- Example Analyses
Most popular product categories
Average delivery time per state
Customer lifetime value estimation
Payment method trends over time
Seller performance ranking
```bash
