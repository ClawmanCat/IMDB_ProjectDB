DROP TABLE IF EXISTS LifespanTMP
CREATE TABLE LifespanTMP (
	name NVARCHAR(255) NOT NULL,
	nickname NVARCHAR(255),
	firstname NVARCHAR(255),
	lastname NVARCHAR(255),
	birthday INT,
	birthmonth INT,
	birthyear INT,
	deathday INT,
	deathmonth INT,
	deathyear INT
);

BULK INSERT LifespanTMP
FROM '%SolutionDir%CSV/biographies_ModelLifespan.csv'
WITH (
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	KEEPNULLS,
	MAXERRORS = 1000000
);

ALTER TABLE ActorLifespan REBUILD WITH (IGNORE_DUP_KEY = ON)

INSERT INTO ActorLifespan (ActorID, Birthdate, Deathdate)
SELECT
	A.ActorID,
	DATEFROMPARTS(T.birthyear, T.birthmonth, T.birthday),
	DATEFROMPARTS(T.deathyear, T.deathmonth, T.deathday)
FROM LifespanTMP T INNER JOIN Actor A ON T.name = A.Fullname

ALTER TABLE ActorLifespan REBUILD WITH (IGNORE_DUP_KEY = ON)

DROP TABLE LifespanTMP;