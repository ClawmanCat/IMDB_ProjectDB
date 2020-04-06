SELECT TOP 20
	A.Fullname AS Name,
	MAX(M.ReleaseYr) - MIN(M.ReleaseYr) AS Career
FROM ActorAppearance AP
	INNER JOIN Movie M ON AP.MovieID = M.MovieID
	INNER JOIN Actor A ON AP.ActorID = A.ActorID
GROUP BY A.Fullname
ORDER BY Career DESC