DROP TABLE IF EXISTS MovieTMP
CREATE TABLE MovieTMP (
	title NVARCHAR(255) NOT NULL,
	episode NVARCHAR(255),
	release_yr INT,
	release_nr INT,
	start_yr INT,
	end_yr INT,
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);

BULK INSERT MovieTMP
FROM '%SolutionDir%CSV/movies_ModelMovie.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

INSERT INTO Movie (Title, Episode, ReleaseYr, ReleaseNr, StartYr, EndYr, MediaType, ReleaseType)
SELECT title, episode, release_yr, release_nr, start_yr, end_yr, media_type, release_type
FROM MovieTMP;

DROP TABLE MovieTMP;