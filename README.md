# 🎬 IMDB SQL Analysis Project

This project presents a set of SQL queries developed for analyzing the **IMDb Top 1000 Movies** dataset.  
The goal is to practice and demonstrate key SQL skills such as data cleaning, aggregation, filtering, ranking, and analytical queries using SQLite and Python.

---

## 📂 Project Structure
```text
IMDB_SQL/
├── imdb_top_1000.csv            # Original dataset
├── imdb_top_1000.db             # SQLite database (generated)
├── Load_csv_to_table.py         # Python script to load and clean data
├── sql/
│   ├── 01_basic_queries.sql
│   ├── 02_ranking_queries.sql
│   ├── 03_yearly_stats.sql
│   ├── 04_director_ratings.sql
│   ├── 05_genre_analysis.sql
│   └── 06_data_quality_checks.sql
└── README.md
```
## Technologies Used

- **SQLite** (via DBeaver)
- **Python** (with `pandas`, `sqlite3`)
- **SQL** (Standard SQL syntax)
- **Pandas for preprocessing**  
- Environment: macOS, Visual Studio Code / DBeaver

## SQL Query List

| No | File | Description |
|----|------|-------------|
| 01 | [`01_basic_queries.sql`](sql/01_basic_queries.sql) | View all movies and count total number |
| 02 | [`02_ranking_queries.sql`](sql/02_ranking_queries.sql) | IMDb ranking and top 10 movies |
| 03 | [`03_yearly_stats.sql`](sql/03_yearly_stats.sql) | Most productive years by movie count |
| 04 | [`04_director_ratings.sql`](sql/04_director_ratings.sql) | Directors with highest average IMDb scores |
| 05 | [`05_genre_analysis.sql`](sql/05_genre_analysis.sql) | Analysis by genre (e.g., Drama) |
| 06 | [`06_data_quality_checks.sql`](sql/06_data_quality_checks.sql) | Detect duplicate titles and integrity issues |

---

## Dataset Info

- Dataset: `IMDb Top 1000 Movies` (source: [IMDb via Kaggle](https://www.kaggle.com/datasets))
- Total Records: 1000 (before cleaning)
- Columns include: `Title`, `Year`, `Genre`, `Rating`, `Votes`, `Gross`, `Director`, `Stars`, etc.

---

## Getting Started

1. Clone this repo
2. (Optional) Create a virtual environment
3. Install dependencies
```bash
pip install pandas

Run the Python script to populate the SQLite database
python Load_csv_to_table.py

Author
Erhan Üstün
Data Engineering Portfolio Project



