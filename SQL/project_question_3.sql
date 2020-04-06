SELECT
  M.Title AS MovieName
FROM ActorAppearance AP
  INNER JOIN Actor A ON A.ActorID = AP.ActorID
  INNER JOIN Movie M ON M.MovieID = AP.MovieID
WHERE A.Fullname = 'Hauer, Rutger' AND M.MediaType = 'MOVIE'
ORDER BY MovieName ASC