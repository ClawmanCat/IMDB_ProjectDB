DROP TABLE IF EXISTS RatingTMP
CREATE TABLE RatingTMP (
	score_distribution_0 VARCHAR(7),
	score_distribution_1 VARCHAR(7),
	score_distribution_2 VARCHAR(7),
	score_distribution_3 VARCHAR(7),
	score_distribution_4 VARCHAR(7),
	score_distribution_5 VARCHAR(7),
	score_distribution_6 VARCHAR(7),
	score_distribution_7 VARCHAR(7),
	score_distribution_8 VARCHAR(7),
	score_distribution_9 VARCHAR(7),
	votes INT,
	score INT,
	title NVARCHAR(255) NOT NULL,
	episode NVARCHAR(255),
	release_yr INT,
	release_nr INT,
	media_type VARCHAR(31),
	release_type VARCHAR(31)
);

BULK INSERT RatingTMP
FROM '%SolutionDir%CSV/ratings_ModelRating.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

INSERT INTO MovieRating (MovieID, ScoreDistribution, Votes, Score)
SELECT
	M.MovieID,
	CONCAT(
		LEFT(T.score_distribution_0, 1),
		LEFT(T.score_distribution_1, 1),
		LEFT(T.score_distribution_2, 1),
		LEFT(T.score_distribution_3, 1),
		LEFT(T.score_distribution_4, 1),
		LEFT(T.score_distribution_5, 1),
		LEFT(T.score_distribution_6, 1),
		LEFT(T.score_distribution_7, 1),
		LEFT(T.score_distribution_8, 1),
		LEFT(T.score_distribution_9, 1)
	),
	T.votes,
	T.score
FROM RatingTMP T INNER JOIN Movie M
	ON  (T.title      = M.Title)
	AND (T.episode    = NULL OR T.episode = M.Episode)
	AND (T.release_yr = NULL OR T.release_yr = M.ReleaseYr)
	AND (T.release_nr = NULL OR T.release_nr = M.ReleaseNR)
	AND (T.media_type = NULL OR T.media_type = M.MediaType)
	
DROP TABLE RatingTMP;