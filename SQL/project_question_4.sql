SELECT
	L.Country AS Country,
	COUNT(M.MovieID) AS NumMovies
FROM Movie M
	INNER JOIN MovieLocation L ON M.MovieID = L.MovieID
	INNER JOIN MovieRating R ON M.MovieID = R.MovieID
WHERE R.Score >= 80
GROUP BY L.Country