import pandas as pd
import sqlite3

# Read the CSV file
df = pd.read_csv('imdb_top_1000.csv')

# Data Cleaning (Preprocessing)

# Runtime_Minutes column
df['Runtime_Minutes'] = df['Runtime'].str.extract(r'(\d+)').astype(int)

# Gross column
# Fill NaN values with '0' or leave as string to become NULL in SQL
df['Gross'].fillna('0', inplace=True) # Fill NaN with string '0' first
df['Gross_Cleaned'] = df['Gross'].str.replace(',', '').str.replace('$', '')

# Check for empty strings or meaningless values like '-', which might cause errors
# Coerce errors will turn invalid parsing into NaN, which we can then fill
df['Gross_Cleaned'] = pd.to_numeric(df['Gross_Cleaned'], errors='coerce')
df['Gross_Millions'] = df['Gross_Cleaned'] / 1_000_000 # Convert to millions (optional)
df['Gross_Millions'].fillna(0, inplace=True) # Fill any remaining NaNs with 0 after cleaning

# Select the relevant columns and write to the database
df_to_db = df[[
    'Poster_Link', 'Series_Title', 'Released_Year', 'Certificate',
    'Runtime_Minutes', 'Genre', 'IMDB_Rating', 'Overview', 'Meta_score',
    'Director', 'Star1', 'Star2', 'Star3', 'Star4', 'No_of_Votes',
    'Gross_Millions'
]]

conn = sqlite3.connect('imdb_top_1000.db') # Creates a new SQLite database file

# Use this to overwrite the table if it already exists
# df_to_db.to_sql('imdb_movies', conn, if_exists='replace', index=False)
# If you created the table manually and the column names match, use this:
df_to_db.to_sql('imdb_movies', conn, if_exists='append', index=False)
conn.commit() # Commits the changes to the database
conn.close()
print("Data has been successfully loaded into the database!")
