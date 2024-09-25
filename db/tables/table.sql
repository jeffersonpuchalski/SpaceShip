USE [Nasa]

-- Path: db/table.sql
-- Create a new table called 'Person' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('Persons', 'U') IS NOT NULL
DROP TABLE Persons
GO
-- Create the table in the specified schema
CREATE TABLE Persons
(
    PersonId INT NOT NULL PRIMARY KEY, -- primary key column
    PersonName [NVARCHAR](50) NOT NULL,
    PersonSurname [NVARCHAR](50) NOT NULL,
    PersonEmail [NVARCHAR](50) NOT NULL,
    PersonPhone [NVARCHAR](50) NOT NULL
);
GO

-- Path: db/table.sql
-- Create a new table called 'Operators' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('Operators', 'U') IS NOT NULL
DROP TABLE Operators
GO
-- Create the table in the specified schema
CREATE TABLE Operators
(
    OperatorId INT NOT NULL PRIMARY KEY, -- primary key column
    OperatorPersonId INT NOT NULL,
    CONSTRAINT FK_Operators_OperatorPersonId FOREIGN KEY (OperatorPersonId) REFERENCES Persons(PersonId)  
);

-- Path: db/table.sql
-- Create a new table called 'Reports' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('Reports', 'U') IS NOT NULL
DROP TABLE Reports
GO
-- Create the table in the specified schema
CREATE TABLE Reports
(
    ReportId INT NOT NULL PRIMARY KEY, -- primary key column
    ReportName [NVARCHAR](50) NOT NULL,
    ReportDescription [NVARCHAR](50) NOT NULL,
    ReportDate [NVARCHAR](50) NOT NULL
);
GO

-- Create a new table called 'Attempts' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('Attempts', 'U') IS NOT NULL
DROP TABLE Attempts
GO
-- Create the table in the specified schema
CREATE TABLE Attempts
(
    AttemptsId INT NOT NULL PRIMARY KEY, -- primary key column
    OperatorId INT NOT NULL,
    DateOfLaunch [NVARCHAR](50) NOT NULL,
    ReportId INT NOT NULL
    CONSTRAINT FK_Attempts_OperatorId FOREIGN KEY (OperatorId) REFERENCES Operators(OperatorId),
    CONSTRAINT FK_Attempts_ReportId FOREIGN KEY (ReportId) REFERENCES Reports(ReportId)
);
GO

-- Path: db/table.sql
-- Create a new table called 'SpaceShips' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SpaceShips', 'U') IS NOT NULL
DROP TABLE SpaceShips
GO
-- Create the table in the specified schema
CREATE TABLE SpaceShips
(
    SpaceShipId INT NOT NULL PRIMARY KEY, -- primary key column
    SpaceShipName [NVARCHAR](50) NOT NULL,
    SpaceShipModel [NVARCHAR](50) NOT NULL,
    SpaceShipYear [NVARCHAR](50) NOT NULL,
    SpaceShipTypeId INT NOT NULL,
    CONSTRAINT FK_SpaceShips_SpaceShipTypeId FOREIGN KEY (SpaceShipTypeId) REFERENCES SpaceShipTypes(SpaceShipTypeId)
);

-- Create the index for SpaceShips table
CREATE CLUSTERED INDEX IX_SpaceShips_SpaceShipId ON SpaceShips(SpaceShipId);
GO


-- Path: db/table.sql
-- Create a new table called 'SpaceShipTypes' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SpaceShipTypes', 'U') IS NOT NULL
DROP TABLE SpaceShipTypes
GO
-- Create the table in the specified schema
CREATE TABLE SpaceShipTypes
(
    SpaceShipTypeId INT NOT NULL PRIMARY KEY, -- primary key column
    SpaceShipTypeName [NVARCHAR](50) NOT NULL,
    SpaceShipTypeDescription [NVARCHAR](50) NOT NULL
);
GO

-- Path: db/table.sql
-- Create a new table called 'SpaceShipThursters' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SpaceShipThursters', 'U') IS NOT NULL
DROP TABLE SpaceShipThursters
GO
-- Create the table in the specified schema
CREATE TABLE SpaceShipThursters
(
    SpaceShipThursterId INT NOT NULL PRIMARY KEY, -- primary key column
    SpaceShipThursterName [NVARCHAR](50) NOT NULL,
    SpaceShipThursterDescription [NVARCHAR](50) NOT NULL,
    SpaceShipThursterSpecsId INT NOT NULL,
    CONSTRAINT FK_SpaceShipThursters_SpaceShipThursterSpecsId FOREIGN KEY (SpaceShipThursterSpecsId) REFERENCES Nasa.SpaceShipThursterSpecs(SpaceShipThursterSpecsId)
);
GO

-- Path: db/table.sql
-- Create a new table called 'SpaceShipThursterSpecs' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SpaceShipThursterSpecs', 'U') IS NOT NULL
DROP TABLE SpaceShipThursterSpecs
GO
-- Create the table in the specified schema
CREATE TABLE SpaceShipThursterSpecs
(
    SpaceShipThursterSpecsId INT NOT NULL PRIMARY KEY, -- primary key column    
    SpaceShipThursterSpecsPower NUMERIC(18, 2) NOT NULL,
    SpaceShipThursterSpecsTorque NUMERIC(18, 2) NOT NULL,
    SpaceShipThursterSpecsRPM NUMERIC(18, 2) NOT NULL,
    SpaceShipThursterCombusitonType INT NOT NULL
);
GO

-- Path: db/table.sql
-- Create a new table called 'SpaceShipCombusitonTypes' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SpaceShipCombusitonTypes', 'U') IS NOT NULL
DROP TABLE SpaceShipCombusitonTypes
GO
-- Create the table in the specified schema
CREATE TABLE SpaceShipCombusitonTypes
(
    SpaceShipCombusitonTypeId INT NOT NULL PRIMARY KEY, -- primary key column
    SpaceShipCombusitonTypeName [NVARCHAR](50) NOT NULL,
    SpaceShipCombusitonTypeDescription [NVARCHAR](50) NOT NULL
);

-- Path: db/table.sql
-- Create a new table called 'DeployLocation' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('DeployLocation', 'U') IS NOT NULL
DROP TABLE DeployLocation
GO
-- Create the table in the specified schema
CREATE TABLE DeployLocation
(
    DeployLocationId INT NOT NULL PRIMARY KEY, -- primary key column
    DeployLocationName [NVARCHAR](50) NOT NULL,
    DeployLocationDescription [NVARCHAR](50) NOT NULL,
    DeployLocationLatitude [NVARCHAR](50) NOT NULL,
    DeployLocationLongitude [NVARCHAR](50) NOT NULL
);
GO