USE [Nasa]

-- Insert Persons
INSERT INTO Persons (
    PersonId,
    PersonName,
    PersonSurname,
    PersonEmail,
    PersonPhone
) VALUES (
    1,
    'John',
    'Doe',
    'john@doe.com',
    '34992111111'
);

-- Insert Operators
INSERT INTO Operators (
    OperatorId,
    OperatorName,
    OperatorPersonId
) VALUES (
    1,
    'John',
    1
);

-- Insert Reports
INSERT INTO Reports (
    ReportId,
    ReportName,
    ReportDescription, 
    ReportDate) 
VALUES (
    1,
    'Report1',
    'Description1',
    '2020-01-01'
);

-- Insert Attempts
INSERT INTO Attempts (
    AttemptsId,
    OperatorId,
    DateOfLaunch,
    ReportId
) VALUES (
    1,
    1,
    '2020-01-01',
    1
);

-- Insert SpaceShips
INSERT INTO SpaceShips (
    SpaceShipId,
    SpaceShipName,
    SpaceShipModel,
    SpaceShipYear,   
    SpaceShipTypeId
) VALUES (
    1,
    'SpaceShip1',
    'Model1',
    '2020-01-01',
    1
);

-- Insert SpaceShipTypes
INSERT INTO SpaceShipTypes (
    SpaceShipTypeId,
    SpaceShipTypeName,
    SpaceShipTypeDescription
) VALUES (
    1,
    'Type1',
    'Description1'
);

-- Insert SpaceShipThursters
INSERT INTO SpaceShipThursterSpecs (
    SpaceShipThursterSpecsId,
    SpaceShipThursterSpecsPower,
    SpaceShipThursterSpecsRPM,
    SpaceShipThursterCombusitonType
) VALUES (
    1,
    100,    
    7000,
    'Type1'
);
GO