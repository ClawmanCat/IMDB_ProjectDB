-- Delta > 0 gemiddelde rating neemt toe met leeftijd, Delta < 0 gemiddelde rating neemt af.
SELECT 
  AVG(O.AvgRating - Y.AvgRating) AS Delta
FROM
  OldRating O INNER JOIN YoungRating Y ON O.ActorID = Y.ActorID;