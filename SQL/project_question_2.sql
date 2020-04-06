SELECT TOP 20
  A.Fullname AS ActorName,
  (MAX(M.ReleaseYr) - MIN(M.ReleaseYr)) AS CarreerLength
FROM ActorAppearance AP
  INNER JOIN Actor A ON A.ActorID = AP.ActorID
  INNER JOIN Movie M ON M.MovieID = AP.MovieID
WHERE M.MediaType = 'MOVIE'
GROUP BY A.Fullname
ORDER BY CarreerLength DESC;