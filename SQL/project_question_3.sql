SELECT TOP 100
	COUNT(A.ActorID) AS Num,
	A.Fullname AS Name
FROM Actor A 
	INNER JOIN ActorAppearance AP ON A.ActorID = AP.ActorID
	INNER JOIN Movie M ON AP.MovieID = M.MovieID
WHERE M.MediaType = 'MOVIE'
GROUP BY A.Fullname
ORDER BY Num DESC