DROP TABLE IF EXISTS GenreTMP
CREATE TABLE GenreTMP (
	title NVARCHAR(255) NOT NULL,
	episode NVARCHAR(255),
	release_yr INT,
	release_nr INT,
	genre NVARCHAR(255),
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);

BULK INSERT GenreTMP
FROM '%SolutionDir%CSV/genres_ModelGenre.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

INSERT INTO MovieGenre (MovieID, Genre)
SELECT M.MovieID, T.genre
FROM GenreTMP T INNER JOIN Movie M
	ON  (T.title      = M.Title)
	AND (T.episode    = NULL OR T.episode    = M.Episode)
	AND (T.release_yr = NULL OR T.release_yr = M.ReleaseYr)
	AND (T.release_nr = NULL OR T.release_nr = M.ReleaseNR)
	AND (T.media_type = NULL OR T.media_type = M.MediaType)
	
DROP TABLE GenreTMP;