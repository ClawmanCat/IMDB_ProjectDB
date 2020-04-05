DROP TABLE IF EXISTS ActorAppearanceTMP
CREATE TABLE ActorAppearanceTMP (
	actor NVARCHAR(255) NOT NULL,
	appeared_in NVARCHAR(255) NOT NULL,
	role NVARCHAR(255),
	episode NVARCHAR(255),
	credited_as NVARCHAR(255),
	billing_position INT,
	release_yr INT,
	release_nr INT,
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);

BULK INSERT ActorAppearanceTMP
FROM '%SolutionDir%CSV/actors_ModelActorAppearance.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

BULK INSERT ActorAppearanceTMP
FROM '%SolutionDir%CSV/actresses_ModelActorAppearance.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

INSERT INTO ActorAppearance (ActorID, MovieID, Role, CreditedAs, BillingPos)
SELECT
	A.ActorID,
	M.MovieID,
	AP.role,
	AP.credited_as,
	AP.billing_position
FROM ActorAppearanceTMP AP
	INNER JOIN Actor A ON  (AP.actor       = A.Fullname)
	INNER JOIN Movie M ON  (AP.appeared_in = M.Title)
	                   AND (AP.episode     = NULL OR AP.episode    = M.Episode)
					   AND (AP.release_yr  = NULL OR AP.release_yr = M.ReleaseYr)
					   AND (AP.release_nr  = NULL OR AP.release_nr = M.ReleaseNr)
					   AND (AP.media_type  = NULL OR AP.media_type = M.MediaType)
DROP TABLE ActorAppearanceTMP;






