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

-- 2. Directors who worked with the same group of 4 actors in multiple films
WITH DirectorStarPairs AS (
    SELECT Director, Star1 AS Star, Series_Title FROM imdb_movies
    UNION ALL
    SELECT Director, Star2 AS Star, Series_Title FROM imdb_movies
    UNION ALL
    SELECT Director, Star3 AS Star, Series_Title FROM imdb_movies
    UNION ALL
    SELECT Director, Star4 AS Star, Series_Title FROM imdb_movies
)
SELECT 
    Director,
    Star,
    COUNT(*) AS OrtakFilmSayisi,
    GROUP_CONCAT(Series_Title) AS OrtakFilmler
FROM DirectorStarPairs
WHERE Star IS NOT NULL
GROUP BY Director, Star
HAVING COUNT(*) > 1
ORDER BY OrtakFilmSayisi DESC
LIMIT 10;
