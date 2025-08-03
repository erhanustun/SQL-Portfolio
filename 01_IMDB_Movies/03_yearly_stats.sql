-- 1. Which year has the most movies?
SELECT Released_Year, COUNT(*) AS Film_Count
FROM imdb_movies
GROUP BY Released_Year
ORDER BY Film_Count DESC;
