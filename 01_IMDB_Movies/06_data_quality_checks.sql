-- 1. Check for duplicate movie titles
SELECT Series_Title, COUNT(*)
FROM imdb_movies
GROUP BY Series_Title
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
