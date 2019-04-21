CREATE FUNCTION WorkshopsCollides
	(@WorkshopID1 INT,
	@WorkshopID2 INT)
	RETURNS BIT
AS
	BEGIN
		DECLARE @Beginning1 TIME
		DECLARE @Beginning2 TIME
		DECLARE @End1 TIME
		DECLARE @End2 TIME
		SET @Beginning1 = (SELECT BeginningTime
						   FROM Workshops
					       WHERE WorkshopID = @WorkshopID1)
		SET @Beginning2 = (SELECT BeginningTime
						   FROM Workshops
					       WHERE WorkshopID = @WorkshopID2)
		SET @End1 = (SELECT EndTime
						   FROM Workshops
					       WHERE WorkshopID = @WorkshopID1)
		SET @End2 = (SELECT EndTime
						   FROM Workshops
					       WHERE WorkshopID = @WorkshopID2)
		IF @Beginning1 <= @End2 AND @End1 >= @Beginning2
			RETURN 1
		RETURN 0
	END