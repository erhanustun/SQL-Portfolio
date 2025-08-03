import pandas as pd
import sqlite3

# CSV'yi oku
df = pd.read_csv('imdb_top_1000.csv')

# Veri Temizleme (Ön İşleme)
# Runtime_Minutes sütunu
df['Runtime_Minutes'] = df['Runtime'].str.extract(r'(\d+)').astype(int)

# Gross sütunu
# NaN değerleri 0 ile doldur veya string olarak bırakıp SQL'de NULL yap
df['Gross'].fillna('0', inplace=True) # NaN'ları önce string '0' ile doldur
df['Gross_Cleaned'] = df['Gross'].str.replace(',', '').str.replace('$', '')

# Boş stringleri veya sadece '-' gibi anlamsız değerleri kontrol et
# Hata verebilecek değerleri NaN yapıp sonra doldurabiliriz
df['Gross_Cleaned'] = pd.to_numeric(df['Gross_Cleaned'], errors='coerce')
df['Gross_Millions'] = df['Gross_Cleaned'] / 1_000_000 # Milyon dolara çevirme (isteğe bağlı)
df['Gross_Millions'].fillna(0, inplace=True) # Temizledikten sonra NaN olanları 0 ile doldur

# İlgili sütunları seç ve veritabanına yaz
df_to_db = df[[
    'Poster_Link', 'Series_Title', 'Released_Year', 'Certificate',
    'Runtime_Minutes', 'Genre', 'IMDB_Rating', 'Overview', 'Meta_score',
    'Director', 'Star1', 'Star2', 'Star3', 'Star4', 'No_of_Votes',
    'Gross_Millions'
]]

conn = sqlite3.connect('imdb_top_1000.db') # Yeni bir SQLite veritabanı dosyası oluşturur

# df_to_db.to_sql('imdb_movies', conn, if_exists='replace', index=False)
# Eğer tabloyu elle oluşturduysan ve sütun isimleri uyuyorsa:
df_to_db.to_sql('imdb_movies', conn, if_exists='append', index=False)
conn.commit() # Değişiklikleri kalıcı hale getirir
conn.close()
print("Veri veritabanına başarıyla yüklendi!")