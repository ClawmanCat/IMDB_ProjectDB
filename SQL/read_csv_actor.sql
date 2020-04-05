DROP TABLE IF EXISTS ActorTMP
CREATE TABLE ActorTMP (
	is_male INT NOT NULL,
	name NVARCHAR(255) NOT NULL,
	firstname NVARCHAR(255),
	lastname NVARCHAR(255),
	nickname NVARCHAR(255)
);

BULK INSERT ActorTMP
FROM '%SolutionDir%CSV/actors_ModelActor.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

BULK INSERT ActorTMP
FROM '%SolutionDir%CSV/actresses_ModelActor.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

INSERT INTO Actor (Male, Fullname, Firstname, Lastname, Nickname)
SELECT 
	CAST(IIF (is_male != 0, 1, 0) AS BIT), 
	name, firstname, lastname, nickname
FROM ActorTMP;

DROP TABLE ActorTMP;