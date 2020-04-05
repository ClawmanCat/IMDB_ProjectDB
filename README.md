# IMDB Project Database System
This project provides SQL files for setting up the IMDB Project Database.
This document describes how to configure the database for local use.

## Setup
1. If using Visual Studio, make sure the module 'Desktop Development with .NET' is installed,
otherwise download the SqlLocalDB utility directly from [Microsoft](https://docs.microsoft.com/en-us/sql/tools/sqllocaldb-utility?view=sql-server-ver15).
  
2. Locate your SqlLocalDB.exe, usually located in:  
`C:\Program Files\Microsoft SQL Server\130\Tools\Binn`
  
3. Run the following commands to create and run the database:  
`SqlLocalDB.exe create IMDB_Project`  
`SqlLocalDB.exe start IMDB_Project`  
`SqlLocalDB.exe info IMDB_Project`  
  
4. This last command will show the 'Instance pipe name', we will need this later.
  

4.5. By default the server will shut down after 10 minutes of inactivity,
and queries will time out after 600 seconds.
If you do not want this, run the following commands:
```
sqlcmd -S <Instance pipe name>
sp_configure 'show advanced options', 1;
GO

RECONFIGURE;
GO

sp_configure 'user instance timeout', 60000;
GO

RECONFIGURE;
GO

sp_configure 'remote query timeout', 0;
GO

RECONFIGURE;

EXIT
```
  
## Running the program
The program will run SQL queries on the existing database.

`--connstr=<URL>`  
Provide the connection string (the Instance pipe name) for the database.
Default is `(LocalDb)\IMDB_Project`                     
`--sql=<FILE1,FILE2,...>`  
Comma seperated list of SQL files to run                                                      
`--outdir=<DIRECTORY>`  
Directory to store the query results. If none is provided, results are printed to the console.  
`--outmode=<file|console>`  
Where to print the results of the query to. The default is console.
`--direct`  
Run queries directly from the console instead of using a SQL file. Implies `--outmode=console`.
