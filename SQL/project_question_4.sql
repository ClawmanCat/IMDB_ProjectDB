SELECT TOP 20
  L.Country AS Country,
  COUNT(M.Title) AS NumMovies
FROM Movie M
  INNER JOIN MovieLocation L ON M.MovieID = L.MovieID
  INNER JOIN MovieRating R   ON M.MovieID = R.MovieID 
WHERE R.Score >= 80 AND M.MediaType = 'MOVIE'
GROUP BY L.Country
ORDER BY NumMovies DESC