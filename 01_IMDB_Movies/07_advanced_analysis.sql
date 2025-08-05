-- 1. Top-rated movie per year using window function
WITH RankedMovies AS (
  SELECT 
    Series_Title,
    Released_Year,
    IMDB_Rating,
    ROW_NUMBER() OVER (PARTITION BY Released_Year ORDER BY IMDB_Rating DESC) AS rn
  FROM imdb_movies
)
SELECT * 
FROM RankedMovies
WHERE rn = 1
ORDER BY Released_Year;
