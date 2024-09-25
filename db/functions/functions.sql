CREATE OR ALTER FUNCTION GET_TOTAL_AMOUNT_OF_SHIPS_BY_SHIP_TYPE(@ship_type_id INT) RETURNS INT
AS
BEGIN
    DECLARE @total_amount_of_ships INT
    SELECT @total_amount_of_ships = COUNT(*) FROM SpaceShips WHERE ShipTypeId = @ship_type_id
    RETURN @total_amount_of_ships
END;
GO


CREATE OR ALTER FUNCTION GET_TOTAL_OF_SHIPS_WITH_NO_OWNER() RETURNS INT
AS
BEGIN
    DECLARE @total_amount_of_ships INT
    SELECT @total_amount_of_ships = COUNT(*) FROM SpaceShips WHERE OwnerId IS NULL
    RETURN @total_amount_of_ships
END;
