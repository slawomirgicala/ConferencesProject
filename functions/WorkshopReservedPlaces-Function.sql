CREATE FUNCTION	WorkshopReservedPlaces
	(@WorkshopID INT)
	RETURNS INT
AS
	BEGIN
		RETURN ISNULL((SELECT SUM(NumberOfParticipants) + SUM(NumberOfStudents)
				       FROM Workshops_OrderDetails
				       WHERE WorkshopID = @WorkshopID AND IsCanceled = 0), 0)
	END
