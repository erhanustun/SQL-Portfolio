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
    COUNT(*) AS CountCommonFilms,
    GROUP_CONCAT(Series_Title) AS CommonFilm
FROM DirectorStarPairs
WHERE Star IS NOT NULL
GROUP BY Director, Star
HAVING COUNT(*) > 1
ORDER BY CountCommonFilms DESC
LIMIT 10;

-- 3. Relationship between IMDb rating and box office gross (binned rating)
SELECT 
  ROUND(IMDB_Rating, 1) AS Rating_Bin,
  AVG(Gross_Millions) AS Avg_Gross
FROM imdb_movies
WHERE Gross_Millions > 0
GROUP BY Rating_Bin
ORDER BY Rating_Bin;


-- 4. Genres with the longest average duration
-- (Assumes each row has one genre - adjust if multiple genres exist per row)
SELECT 
  Genre, 
  AVG(Runtime_Minutes) AS Avg_Duration
FROM imdb_movies
GROUP BY Genre
ORDER BY Avg_Duration DESC
LIMIT 10;

-- 5. Top 10 highest-rated actors (appearing in at least 5 movies)
-- Combine all actors into a unified list with their ratings
SELECT 
  Star, 
  AVG(IMDB_Rating) AS Avg_Rating, 
  COUNT(*) AS Film_Count
FROM (
  SELECT Star1 AS Star, IMDB_Rating FROM imdb_movies
  UNION ALL
  SELECT Star2 AS Star, IMDB_Rating FROM imdb_movies
  UNION ALL
  SELECT Star3 AS Star, IMDB_Rating FROM imdb_movies
  UNION ALL
  SELECT Star4 AS Star, IMDB_Rating FROM imdb_movies
) AS AllStars
GROUP BY Star
HAVING COUNT(*) >= 5
ORDER BY Avg_Rating DESC
LIMIT 10;
