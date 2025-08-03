-- 1. List of movies in the 'Drama' genre
SELECT Series_Title, Genre, IMDB_Rating
FROM imdb_movies
WHERE Genre LIKE '%Drama%'
ORDER BY IMDB_Rating DESC;
