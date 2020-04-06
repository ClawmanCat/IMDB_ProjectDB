DROP TABLE IF EXISTS LanguageTMP
CREATE TABLE LanguageTMP (
	title NVARCHAR(255) NOT NULL,
	episode NVARCHAR(255),
	language NVARCHAR(255),
	details NVARCHAR(255),
	release_yr INT,
	release_nr INT,
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);

BULK INSERT LanguageTMP
FROM '%SolutionDir%CSV/language_ModelMovieLanguage.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

ALTER TABLE MovieLanguage REBUILD WITH (IGNORE_DUP_KEY = ON)

INSERT INTO MovieLanguage (MovieID, Language, Details)
SELECT M.MovieID, T.language, T.details
FROM LanguageTMP T INNER JOIN Movie M
	ON  (T.title      = M.Title)
	AND (T.episode    = NULL OR T.episode    = M.Episode)
	AND (T.release_yr = NULL OR T.release_yr = M.ReleaseYr)
	AND (T.release_nr = NULL OR T.release_nr = M.ReleaseNR)
	AND (T.media_type = NULL OR T.media_type = M.MediaType)
	
ALTER TABLE MovieLanguage REBUILD WITH (IGNORE_DUP_KEY = OFF)
	
DROP TABLE LanguageTMP;