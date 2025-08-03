-- 1. Find the IMDb rank of the movie 'The Godfather'
SELECT * FROM (
    SELECT
        Series_Title,
        IMDB_Rating,
        ROW_NUMBER() OVER (ORDER BY IMDB_Rating DESC) AS Ranking
    FROM imdb_movies
) AS RankedMovies
WHERE Series_Title = 'The Godfather';

-- 2. Top 10 movies with the highest IMDb rating
SELECT Series_Title, Released_Year, IMDB_Rating
FROM imdb_movies
ORDER BY IMDB_Rating DESC
LIMIT 10;
