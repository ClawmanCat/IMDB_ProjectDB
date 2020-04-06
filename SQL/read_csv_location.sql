DROP TABLE IF EXISTS LocationTMP;
CREATE TABLE LocationTMP(
	title NVARCHAR(255) NOT NULL,
	episode NVARCHAR(255),
	release_yr INT,
	release_nr INT,
	full_address NVARCHAR(255) NOT NULL,
	country NVARCHAR(255) NOT NULL,
	details NVARCHAR(255),
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);


BULK INSERT LocationTMP
FROM '%SolutionDir%CSV/locations_ModelLocation.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

ALTER TABLE MovieLocation REBUILD WITH (IGNORE_DUP_KEY = ON)

INSERT INTO MovieLocation (MovieID, FullAddress, Country, Details)
SELECT M.MovieID, T.full_address, T.country, T.details
FROM LocationTMP T INNER JOIN Movie M
	ON  (T.title      = M.Title)
	AND (T.episode    = NULL OR T.episode    = M.Episode)
	AND (T.release_yr = NULL OR T.release_yr = M.ReleaseYr)
	AND (T.release_nr = NULL OR T.release_nr = M.ReleaseNR)
	AND (T.media_type = NULL OR T.media_type = M.MediaType);

ALTER TABLE MovieLocation REBUILD WITH (IGNORE_DUP_KEY = ON)
	
DROP TABLE LocationTMP;