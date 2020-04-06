-- This seems to work 50% of the time, I don't know why, sometimes it just keeps checking the constraint anyway.
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_MSForEachTable 'DROP TABLE IF EXISTS ?'
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';


CREATE TABLE Actor(
	ActorID INT NOT NULL IDENTITY(1, 1),
	Male BIT NOT NULL,
	Fullname NVARCHAR(255) NOT NULL,
	Firstname NVARCHAR(255),
	Lastname NVARCHAR(255),
	Nickname NVARCHAR(255),
	PRIMARY KEY (ActorID)
);


CREATE TABLE Movie(
	MovieID INT NOT NULL IDENTITY(1, 1),
	Title NVARCHAR(255) NOT NULL,
	Episode NVARCHAR(255),
	ReleaseYr INT,
	ReleaseNr INT,
	StartYr INT,
	EndYr INT,
	MediaType VARCHAR(31) 
		CHECK (MediaType IN (
			'MOVIE', 
			'TV_SERIES', 
			'MINI_TV_SERIES', 
			'VIDEO_GAME', 
			'UNDEFINED', 
			NULL
		)
	),
	ReleaseType VARCHAR(31) 
		CHECK (ReleaseType IN (
			'CINEMA', 
			'TV', 
			'VIDEO',
			'UNDEFINED', 
			NULL
		)
	),
	PRIMARY KEY (MovieID)
);


CREATE TABLE ActorAppearance(
	ActorID INT NOT NULL,
	MovieID INT NOT NULL,
	Role NVARCHAR(255),
	CreditedAs NVARCHAR(255),
	BillingPos INT,
	PRIMARY KEY (ActorID, MovieID),
	FOREIGN KEY (ActorID) REFERENCES Actor(ActorID),
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);


CREATE TABLE ActorLifespan(
	ActorID INT NOT NULL,
	Birthdate DATE,
	Deathdate DATE,
	PRIMARY KEY (ActorID),
	FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)
);


CREATE TABLE MovieGenre(
	MovieID INT NOT NULL,
	Genre NVARCHAR(255) NOT NULL,
	PRIMARY KEY (MovieID, Genre),
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);


CREATE TABLE MovieLanguage(
	MovieID INT NOT NULL,
	Language NVARCHAR(255) NOT NULL,
	Details NVARCHAR(255),
	PRIMARY KEY (MovieID, Language),
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);


CREATE TABLE MovieLocation(
	MovieID INT NOT NULL,
	FullAddress NVARCHAR(255) NOT NULL,
	Country NVARCHAR(255) NOT NULL,
	Details NVARCHAR(255),
	PRIMARY KEY (MovieID, FullAddress),
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);


CREATE TABLE MovieRating(
	MovieID INT NOT NULL,
	ScoreDistribution CHAR(10) NOT NULL CHECK (ScoreDistribution IN ('N', 'A', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9')),
	Votes INT NOT NULL,
	Score INT NOT NULL CHECK (Score BETWEEN 0 AND 100),
	PRIMARY KEY (MovieID),
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);