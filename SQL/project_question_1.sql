SELECT 
    LEFT(A.Lastname, 1) AS NameChar, 
    AVG(AP.BillingPos) AS AvgPosition 
FROM 
    Actor A INNER JOIN ActorAppearance AP ON A.ActorID = AP.ActorID
GROUP BY LEFT(A.Lastname, 1)
ORDER BY A.Lastname DESC;