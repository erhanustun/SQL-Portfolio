-- 1. Directors with the highest average IMDb rating (at least 5 movies and average rating > 8)
SELECT Director, COUNT(*) AS Film_Count, AVG(IMDB_Rating) AS Average_Score
FROM imdb_movies
GROUP BY Director
HAVING COUNT(*) >= 5 AND AVG(IMDB_Rating) > 8
ORDER BY Average_Score DESC;
