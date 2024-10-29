SELECT m.movieId, 
       m.title, 
       AVG(r.rating) AS average_rating
FROM movie m
JOIN rating r ON m.movieId = r.movieId
GROUP BY m.movieId, m.title
ORDER BY average_rating DESC;
