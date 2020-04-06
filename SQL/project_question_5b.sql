CREATE VIEW OldRating AS
SELECT
  AP.ActorID AS ActorID,
  AVG(R.Score) AS AvgRating
FROM ActorAppearance AP
  INNER JOIN Movie M         ON M.MovieID = AP.MovieID
  INNER JOIN MovieRating R   ON M.MovieID = R.MovieID
  INNER JOIN ActorLifespan L ON AP.ActorID = L.ActorID
WHERE (
  M.MediaType = 'MOVIE' AND 
  -- ReleaseYr - min(ReleaseYr) >= (max(ReleaseYr) - min(ReleaseYr)) / 2
  M.ReleaseYr - (
    SELECT MIN(M2.ReleaseYr) 
    FROM Movie M2 INNER JOIN ActorAppearance AP2 ON M2.MovieID = AP2.MovieID 
    WHERE AP2.ActorID = AP.ActorID
  ) >= ((
    SELECT MAX(M2.ReleaseYr)
    FROM Movie M2 INNER JOIN ActorAppearance AP2 ON M2.MovieID = AP2.MovieID
    WHERE AP2.ActorID = AP.ActorID
  ) - (
    SELECT MIN(M2.ReleaseYr) 
    FROM Movie M2 INNER JOIN ActorAppearance AP2 ON M2.MovieID = AP2.MovieID 
    WHERE AP2.ActorID = AP.ActorID
  )) / 2
) GROUP BY AP.ActorID;